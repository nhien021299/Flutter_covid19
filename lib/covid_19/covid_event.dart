import 'package:equatable/equatable.dart';

abstract class CovidEvent extends Equatable {
  @override
  List<Object> get props => [] ;
}

class SearchNameEvent extends CovidEvent{
  final String searchName;
  SearchNameEvent({this.searchName});
}

class ErrorEvent extends CovidEvent{
  final String searchString;
  ErrorEvent({this.searchString});
}

class InitialEvent extends CovidEvent{

}

class ClearResultEvent extends CovidEvent{

}