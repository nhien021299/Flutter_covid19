import 'package:equatable/equatable.dart';

abstract class CovidEvent extends Equatable {
  @override
  List<Object> get props => [] ;
}

class SearchNameEvent extends CovidEvent{
  final String searchName;
  SearchNameEvent({required this.searchName});
}

class ErrorEvent extends CovidEvent{
  final String searchString;
  ErrorEvent({required this.searchString});
}

class InitialEvent extends CovidEvent{

}

class ClearResultEvent extends CovidEvent{

}