import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_and_profile_model.dart';
import 'package:shop_app/networks/remote/dio_helper.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool hide = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    hide = !hide;
    suffix = hide ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      method: 'login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // debugPrint >> accept only string
      //debugPrint('${value.data}');
      //debugPrint(value.data.toString());
      var loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

}
