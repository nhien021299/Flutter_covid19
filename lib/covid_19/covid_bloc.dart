import 'dart:convert' as convert;
import 'package:http/http.dart';
import 'package:final_flutter_project/class/CovidInfo.dart';
import 'package:final_flutter_project/covid_19/covid_event.dart';
import 'package:final_flutter_project/covid_19/covid_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidState(listCovidInfo: const <CovidInfo>[]));

  var rawData = [];

  List<CovidInfo> covidInfos = [];
  List<CovidInfo> searchedCovidInfos = [];

  Stream<CovidState> _getCountriesInfo() async* {
    final url = Uri.parse("https://api.covid19api.com/summary");
    var response = await get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    rawData = jsonResponse["Countries"] as List;

    //Create VN var
    String? _vnTotalConfirmed;
    String? _vnTotalDeaths;
    String? _vnTotalRecovered;

    //Get global
    final String _totalConfirmed =
        "${jsonResponse["Global"]["TotalConfirmed"]}";
    final String _totalDeaths = "${jsonResponse["Global"]["TotalDeaths"]}";
    final String _totalRecovered =
        "${jsonResponse["Global"]["TotalRecovered"]}";

    //Get countries;
    for (int i = 0; i < rawData.length; i++) {
      CovidInfo covidInfo = CovidInfo(
          country: rawData[i]["Country"],
          totalConfirmed: rawData[i]["TotalConfirmed"],
          totalDeaths: rawData[i]["TotalDeaths"],
          totalRecovered: rawData[i]["TotalRecovered"],
          newConfirmed: rawData[i]["NewConfirmed"],
          newDeaths: rawData[i]["NewDeaths"],
          newRecovered: rawData[i]["NewRecovered"],
          dateTime: rawData[i]["Date"]);
      covidInfos.add(covidInfo);
      if (rawData[i]["Country"] == "Viet Nam") {
        _vnTotalConfirmed = "${rawData[i]["TotalConfirmed"]}";
        _vnTotalDeaths = "${rawData[i]["TotalDeaths"]}";
        _vnTotalRecovered = "${rawData[i]["TotalRecovered"]}";
      }
    }
    yield state.copyWith(
        listCovidInfo: covidInfos,
        totalConfirmed: _totalConfirmed,
        totalDeaths: _totalDeaths,
        totalRecovered: _totalRecovered,
        vnTotalConfirmed: _vnTotalConfirmed,
        vnTotalDeaths: _vnTotalDeaths,
        vnTotalRecovered: _vnTotalRecovered);
  }

  Stream<CovidState> _getSearchResults(CovidEvent event) async* {
    final _searchName = (event as SearchNameEvent).searchName;
    searchedCovidInfos.clear();
    for (final item in state.listCovidInfo!) {
      if (item.country
          .toString()
          .toLowerCase()
          .contains(_searchName.toLowerCase())) {
        searchedCovidInfos.add(item);
      }
    }
    yield state.copyWith(searchedCovidInfos: searchedCovidInfos);
  }

  @override
  Stream<CovidState> mapEventToState(CovidEvent event) async* {
    switch (event.runtimeType) {
      case InitialEvent:
        yield* _getCountriesInfo();
        break;
      case SearchNameEvent:
        yield* _getSearchResults(event);
        break;
      default:
        break;
    }
  }
}
