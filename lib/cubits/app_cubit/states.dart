
import '../../models/change_favorites_model.dart';
import '../../models/login_and_profile_model.dart';

abstract class AppStates{}

class InitialAppState extends AppStates{}

class ChangeBNVIndexState extends AppStates{}

class LoadingHomeModelState extends AppStates{}
class SuccessHomeModelState extends AppStates{}
class ErrorHomeModelState extends AppStates{}


class LoadingCategoriesState extends AppStates{}
class SuccessCategoriesState extends AppStates{}
class ErrorCategoriesState extends AppStates{}


class ChangeFavoritesState extends AppStates{}
class SuccessChangeFavoritesState extends AppStates{
  final ChangeFavoritesModel model;
  SuccessChangeFavoritesState(this.model);
}
class ErrorChangeFavoritesState extends AppStates{}


class LoadingGetFavoritesState extends AppStates{}
class SuccessGetFavoritesState extends AppStates{}
class ErrorGetFavoritesState extends AppStates{}


class GetDataLoadingState extends AppStates{}
class GetDataSuccessState extends AppStates{
  final LoginModel profileData;
  GetDataSuccessState(this.profileData);
}
class GetDataErrorState extends AppStates{
  final String error;
  GetDataErrorState(this.error);
}


class UpdateDataLoadingState extends AppStates{}
class UpdateDataSuccessState extends AppStates{}
class UpdateDataErrorState extends AppStates{}
