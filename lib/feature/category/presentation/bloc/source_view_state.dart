import 'package:general_information/model/source/source_model.dart';

abstract class SourceState {}

class SourceInitialState extends SourceState {}
class SourceLoadingState extends SourceState {}

class SourceSuccessState extends SourceState {
  List<Source> sourceList ; 
  SourceSuccessState({required this.sourceList});
}

class SourceErrorState extends SourceState {
  String errorMessage;
  SourceErrorState({required this.errorMessage});
}
