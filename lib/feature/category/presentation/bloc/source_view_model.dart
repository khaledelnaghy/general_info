import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_information/core/apis/api_manger.dart';
import 'package:general_information/feature/category/presentation/bloc/source_view_state.dart';

class SourceViewModel extends Cubit<SourceState> {
  SourceViewModel() : super(SourceLoadingState());

  void getSources(String categoryId) async {
    try {
      emit(SourceLoadingState());
      var response = await ApiManger.getSources(categoryId);
      if (response?.status == "error") {
        emit(SourceErrorState(errorMessage: response!.message!));
        return;
      }
      if (response?.status == "ok") {
        emit(SourceSuccessState(sourceList: response!.sources!));
        return;
      }
    } catch (e) {
      emit(SourceErrorState(errorMessage: e.toString()));
    }
  }
}
