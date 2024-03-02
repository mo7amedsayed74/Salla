import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/search_cubit/search_states.dart';
import 'package:shop_app/networks/remote/dio_helper.dart';

import '../../constants.dart';
import '../../models/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchinitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void searchProduct(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      method: 'products/search',
      data: {
        'text' : text,
      },
      token: token,
    ).then((value){
      searchModel = SearchModel.fromJson(value.data);
      //debugPrint(value.data.toString());
      emit(SearchSuccessState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(SearchErrorState());
    });
  }
}
