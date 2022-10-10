import 'package:equatable/equatable.dart';
import 'package:final_flutter_project/model/covid_model.dart';

class CovidState extends Equatable {
  final bool? error;
  final List<CovidModel>? listCovidInfo;
  final List<CovidModel>? searchedCovidInfos;
  final CovidModel? globalInfo;

  CovidState({
    this.error,
    this.listCovidInfo,
    this.searchedCovidInfos,
    this.globalInfo,
  });

  CovidState copyWith({
    bool? error,
    List<CovidModel>? listCovidInfo,
    List<CovidModel>? searchedCovidInfos,
    CovidModel? globalInfo,
  }) =>
      CovidState(
        error: error ?? this.error,
        listCovidInfo: listCovidInfo ?? this.listCovidInfo,
        searchedCovidInfos: searchedCovidInfos ?? this.searchedCovidInfos,
        globalInfo: globalInfo ?? this.globalInfo,
      );

  @override
  List<Object?> get props => [
        error,
        listCovidInfo,
        searchedCovidInfos,
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
