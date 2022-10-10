import 'dart:convert' as convert;
import 'package:http/http.dart';
import 'package:final_flutter_project/model/covid_model.dart';
import 'package:final_flutter_project/covid_19/bloc/covid_event.dart';
import 'package:final_flutter_project/covid_19/bloc/covid_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidState(listCovidInfo: const <CovidModel>[])) {
    on<InitialEvent>(_getCountriesInfo);
    on<SearchNameEvent>(_getSearchResults);
  }

  var countries = [];
  CovidModel? global;

  List<CovidModel> covidInfos = [];
  List<CovidModel> searchedCovidInfos = [];

  _getCountriesInfo(InitialEvent event, Emitter<CovidState> emit) async {
    final url = Uri.parse("https://api.covid19api.com/summary");
    var response = await get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    countries = jsonResponse["Countries"] as List;
    global = CovidModel.fromJson(jsonResponse["Global"]);

    //Get countries;
    covidInfos = countries.map((e) => CovidModel.fromJson(e)).toList();

    print(covidInfos.length);

    emit(state.copyWith(
      listCovidInfo: covidInfos,
      searchedCovidInfos: covidInfos,
      globalInfo: global,
    ));
  }

  _getSearchResults(SearchNameEvent event, Emitter<CovidState> emit) async {
    final _searchName = event.searchName;
    searchedCovidInfos.clear();
    if (_searchName.isNotEmpty) {
      searchedCovidInfos = state.listCovidInfo
              ?.where((e) => e.country
                  .toString()
                  .toLowerCase()
                  .contains(_searchName.toLowerCase()))
              .toList() ??
          [];
    } else {
      searchedCovidInfos = List.from(state.listCovidInfo ?? []);
    }
    emit(state.copyWith(searchedCovidInfos: searchedCovidInfos));
  }
}
