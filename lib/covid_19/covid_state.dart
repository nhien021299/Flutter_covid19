import 'package:equatable/equatable.dart';
import 'package:final_flutter_project/class/CovidInfo.dart';

class CovidState extends Equatable {

  final String totalConfirmed;
  final String totalDeaths;
  final String totalRecovered;
  final String vnTotalConfirmed;
  final String vnTotalDeaths;
  final String vnTotalRecovered;
  final bool error;
  final List<CovidInfo> listCovidInfo;

  CovidState({
    this.totalConfirmed = "",
    this.totalDeaths = "",
    this.totalRecovered = "",
    this.vnTotalConfirmed = "",
    this.vnTotalDeaths = "" ,
    this.vnTotalRecovered = "",
    this.error = true,
    this.listCovidInfo,
  });

  CovidState copyWith({
    String totalConfirmed,
    String totalDeaths,
    String totalRecovered,
    String vnTotalConfirmed,
    String vnTotalDeaths,
    String vnTotalRecovered,
    bool error,
    List<CovidInfo> listCovidInfo,
  }) =>
      CovidState(
        totalConfirmed: totalConfirmed ,
        totalDeaths: totalDeaths,
        totalRecovered: totalRecovered,
        vnTotalConfirmed: vnTotalConfirmed,
        vnTotalDeaths: vnTotalDeaths,
        vnTotalRecovered: vnTotalRecovered,
        error: error,
        listCovidInfo: listCovidInfo,
      );

  @override
  List<Object> get props => [totalConfirmed, totalDeaths, totalRecovered , vnTotalConfirmed, vnTotalDeaths, vnTotalRecovered, error ,listCovidInfo];

  @override
  bool operator ==(Object other) {
    if (props == null || props.isEmpty) {
      return false;
    }
    return super == other;
  }

  @override
  bool get stringify => true;

  @override
  int get hashCode => super.hashCode;
}