import 'package:equatable/equatable.dart';
import 'package:final_flutter_project/class/CovidInfo.dart';

class CovidState extends Equatable {
  String? totalConfirmed;
  String? totalDeaths;
  String? totalRecovered;
  String? vnTotalConfirmed;
  String? vnTotalDeaths;
  String? vnTotalRecovered;
  bool? error;
  List<CovidInfo>? listCovidInfo;
  List<CovidInfo>? searchedCovidInfos;

  CovidState(
      {this.totalConfirmed,
      this.totalDeaths,
      this.totalRecovered,
      this.vnTotalConfirmed,
      this.vnTotalDeaths,
      this.vnTotalRecovered,
      this.error,
      this.listCovidInfo,
      this.searchedCovidInfos});

  CovidState copyWith({
    String? totalConfirmed,
    String? totalDeaths,
    String? totalRecovered,
    String? vnTotalConfirmed,
    String? vnTotalDeaths,
    String? vnTotalRecovered,
    bool? error,
    List<CovidInfo>? listCovidInfo,
    List<CovidInfo>? searchedCovidInfos,
  }) =>
      CovidState(
        totalConfirmed: totalConfirmed ?? this.totalConfirmed,
        totalDeaths: totalDeaths ?? this.totalDeaths,
        totalRecovered: totalRecovered ?? this.totalRecovered,
        vnTotalConfirmed: vnTotalConfirmed ?? this.vnTotalConfirmed,
        vnTotalDeaths: vnTotalDeaths ?? this.vnTotalConfirmed,
        vnTotalRecovered: vnTotalRecovered ?? this.vnTotalRecovered,
        error: error ?? this.error,
        listCovidInfo: listCovidInfo ?? this.listCovidInfo,
        searchedCovidInfos: searchedCovidInfos ?? this.listCovidInfo,
      );

  @override
  List<Object> get props => [
        totalConfirmed ?? "",
        totalDeaths ?? "",
        totalRecovered ?? "",
        vnTotalConfirmed ?? "",
        vnTotalDeaths ?? "",
        vnTotalRecovered ?? "",
        error ?? false,
        listCovidInfo ?? [],
        searchedCovidInfos ?? [],
      ];

  @override
  bool operator ==(Object other) {
    if (props.isEmpty) {
      return false;
    }
    return super == other;
  }

  @override
  bool get stringify => true;

  @override
  int get hashCode => super.hashCode;
}
