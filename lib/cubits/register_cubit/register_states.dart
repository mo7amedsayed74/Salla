import '../../models/login_and_profile_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterChangePasswordVisibilityState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final LoginModel loginModelToRegister;
  RegisterSuccessState(this.loginModelToRegister);
}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);
}
