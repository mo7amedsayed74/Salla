import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/categories_screen.dart';
import 'package:shop_app/Screens/favorite_screen.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/networks/remote/dio_helper.dart';
import 'package:shop_app/Screens/products_screen.dart';
import 'package:shop_app/Screens/settings_screen.dart';

import '../../constants.dart';
import '../../models/change_favorites_model.dart';
import '../../models/home_model.dart';
import '../../models/login_and_profile_model.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  /// Bottom Navigation Bar
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.category_outlined,
      ),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite_border,
      ),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  int currentIndex = 0;

  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBNVIndexState());
  }

  /// Home
  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getNewProducts() {
    emit(LoadingHomeModelState());
    DioHelper.getData(
      method: 'home',
      token: token,
    ).then(
      (value) {
        //debugPrint('${homeModel!.status}');
        //debugPrint(homeModel!.data!.banners![0].image!);
        homeModel = HomeModel.fromJson(value.data);

        for (var element in homeModel!.data!.products!) {
          favorites.addAll({
            element.id!: element.inFavorites!,
          });
        }

        emit(SuccessHomeModelState());
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        emit(ErrorHomeModelState());
      },
    );
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(LoadingCategoriesState());
    DioHelper.getData(
      method: 'categories',
    ).then(
      (value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        //debugPrint('${homeModel!.status}');
        //debugPrint(homeModel!.data!.banners![0].image!);
        emit(SuccessCategoriesState());
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        emit(ErrorCategoriesState());
      },
    );
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesState());
    DioHelper.postData(
      method: 'favorites',
      data: {
        "product_id": productId,
      },
      token: token,
    ).then(
      (value) {
        //debugPrint(value.data.toString());
        changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
        if (changeFavoritesModel!.status == false) {
          favorites[productId] = !favorites[productId]!;
        } else {
          getFavorites(); // to add new favorites to (Favorite Screen)
        }
        emit(SuccessChangeFavoritesState(changeFavoritesModel!));
      },
    ).catchError(
      (error) {
        favorites[productId] = !favorites[productId]!;
        emit(ErrorChangeFavoritesState());
      },
    );
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(LoadingGetFavoritesState());
    DioHelper.getData(
      method: 'favorites',
      token: token,
    ).then(
      (value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        //debugPrint(value.data.toString());
        emit(SuccessGetFavoritesState());
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        emit(ErrorGetFavoritesState());
      },
    );
  }

  LoginModel? profileData;

  void getUserData() {
    emit(GetDataLoadingState());
    DioHelper.getData(
      method: 'profile',
      token: token,
    ).then(
      (value) {
        profileData = LoginModel.fromJson(value.data);
        emit(GetDataSuccessState(profileData!));
      },
    ).catchError((error) {
      debugPrint(error.toString());
      emit(GetDataErrorState(error.toString()));
    });
  }

  void updateUserData({
    required Map<String,dynamic> data,
}) {
    emit(UpdateDataLoadingState());
    DioHelper.putData(
      method: 'update-profile',
      token: token,
      data: data,
    ).then((value){
      profileData = LoginModel.fromJson(value.data);
      emit(UpdateDataSuccessState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(UpdateDataErrorState());
    });
  }


}
