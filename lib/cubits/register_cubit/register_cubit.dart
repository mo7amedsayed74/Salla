import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/register_cubit/register_states.dart';
import 'package:shop_app/models/login_and_profile_model.dart';
import 'package:shop_app/networks/remote/dio_helper.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool hide = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    hide = !hide;
    suffix = hide ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      method: 'register',
      data: {
        'name':name,
        'phone':phone,
        'email': email,
        'password': password,
      },
    ).then((value) {
      // debugPrint >> accept only string
      //debugPrint('${value.data}');
      //debugPrint(value.data.toString());
      //loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(LoginModel.fromJson(value.data)));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

}
