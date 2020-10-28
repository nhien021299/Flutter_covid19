import 'dart:convert' as convert;
import 'package:http/http.dart';
import 'package:final_flutter_project/class/CovidInfo.dart';
import 'package:final_flutter_project/covid_19/covid_event.dart';
import 'package:final_flutter_project/covid_19/covid_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {

  CovidBloc() : super(CovidState(listCovidInfo: null)){}

  Future<List<CovidInfo>> _getCountriesInfo() async {
    final url = "https://api.covid19api.com/summary";
    var response = await get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    // print('jsonResponse TotalConfirmed: ${jsonResponse["Global"]["TotalConfirmed"]}');
    List<CovidInfo> covidInfos = [];
    var countries = jsonResponse["Countries"] as List;
    for (int i = 0 ; i< countries.length ; i ++) {
      CovidInfo covidInfo = CovidInfo(
        country: countries[i]["Country"],
        totalConfirmed: countries[i]["TotalConfirmed"],
        totalDeaths: countries[i]["TotalDeaths"],
        totalRecovered: countries[i]["TotalRecovered"],
        newConfirmed: countries[i]["NewConfirmed"],
        newDeaths: countries[i]["NewDeaths"],
        newRecovered: countries[i]["NewRecovered"],
        dateTime: countries[i]["Date"]
      );
      covidInfos.add(covidInfo);
    }
    return covidInfos;
  }

  Future<List<CovidInfo>> _getSearchResults(String searchString) async {
    final url = "https://api.covid19api.com/summary";
    var response = await get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    // print('jsonResponse TotalConfirmed: ${jsonResponse["Global"]["TotalConfirmed"]}');
    List<CovidInfo> covidInfos = [];
    var countries = jsonResponse["Countries"] as List;
    for (int i = 0 ; i< countries.length ; i ++) {
      if(countries[i]["Country"].toString().toLowerCase().contains(searchString.toLowerCase()) ||
          countries[i]["CountryCode"].toString().toLowerCase().contains(searchString.toLowerCase())){
        CovidInfo covidInfo = CovidInfo(
            country: countries[i]["Country"],
            totalConfirmed: countries[i]["TotalConfirmed"],
            totalDeaths: countries[i]["TotalDeaths"],
            totalRecovered: countries[i]["TotalRecovered"],
            newConfirmed: countries[i]["NewConfirmed"],
            newDeaths: countries[i]["NewDeaths"],
            newRecovered: countries[i]["NewRecovered"],
            dateTime: countries[i]["Date"]
        );
        covidInfos.add(covidInfo);
      }
    }
    return covidInfos;
  }


  @override
  Stream<CovidState> mapEventToState(CovidEvent event) async* {
    switch(event.runtimeType){
      case InitialEvent:
        final url = "https://api.covid19api.com/summary";
        var response = await get(url);
        var jsonResponse = convert.jsonDecode(response.body);
        final String _totalConfirmed = "${jsonResponse["Global"]["TotalConfirmed"]}";
        final String _totalDeaths = "${jsonResponse["Global"]["TotalDeaths"]}";
        final String _totalRecovered = "${jsonResponse["Global"]["TotalRecovered"]}";
        var countries = jsonResponse["Countries"] as List;
        for (int i = 0 ; i< countries.length ; i ++){
          if(countries[i]["Country"] == "Viet Nam"){
            final String _vnTotalConfirmed = "${countries[i]["TotalConfirmed"]}";
            final String _vnTotalDeaths = "${countries[i]["TotalDeaths"]}";
            final String _vnTotalRecovered = "${countries[i]["TotalRecovered"]}";
            yield state.copyWith(
              listCovidInfo: await _getCountriesInfo(),
              totalConfirmed: _totalConfirmed,
              totalDeaths: _totalDeaths,
              totalRecovered: _totalRecovered,
              vnTotalConfirmed: _vnTotalConfirmed,
              vnTotalDeaths: _vnTotalDeaths,
              vnTotalRecovered: _vnTotalRecovered
            );
          }
        }
        break;
      case SearchNameEvent:
        final _searchName = (event as SearchNameEvent).searchName;
        final url = "https://api.covid19api.com/summary";
        var response = await get(url);
        var jsonResponse = convert.jsonDecode(response.body);
        final String _totalConfirmed = "${jsonResponse["Global"]["TotalConfirmed"]}";
        final String _totalDeaths = "${jsonResponse["Global"]["TotalDeaths"]}";
        final String _totalRecovered = "${jsonResponse["Global"]["TotalRecovered"]}";
        var countries = jsonResponse["Countries"] as List;
        for (int i = 0 ; i< countries.length ; i ++){
          if(countries[i]["Country"] == "Viet Nam"){
            final String _vnTotalConfirmed = "${countries[i]["TotalConfirmed"]}";
            final String _vnTotalDeaths = "${countries[i]["TotalDeaths"]}";
            final String _vnTotalRecovered = "${countries[i]["TotalRecovered"]}";
            yield state.copyWith(
                listCovidInfo: await _getSearchResults(_searchName),
                totalConfirmed: _totalConfirmed,
                totalDeaths: _totalDeaths,
                totalRecovered: _totalRecovered,
                vnTotalConfirmed: _vnTotalConfirmed,
                vnTotalDeaths: _vnTotalDeaths,
                vnTotalRecovered: _vnTotalRecovered
            );
          }
        }
        break;
      default:
        break;
    }
  }
}

