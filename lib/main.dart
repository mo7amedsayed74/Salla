import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/login_screen.dart';
import 'package:shop_app/Screens/on_boarding_screen.dart';
import 'package:shop_app/app&layout/shop_home_layout.dart';
import 'package:shop_app/networks/local/cache_helper.dart';
import 'package:shop_app/networks/remote/dio_helper.dart';
import 'app&layout/my_app.dart';
import 'constants.dart';
import 'networks/remote/bloc_observer.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? showOnBoardingScreen = CacheHelper.getData(key: 'showOnBoardingScreen');
  token = CacheHelper.getData(key: 'token');
  Widget screenToShow;

  if(showOnBoardingScreen==null){
    screenToShow = const OnBoardingScreen();
  }else if(token==null){
    screenToShow = LoginScreen();
  }else{
    screenToShow = const HomeLayout();
  }

  //debugPrint(token);
  // 3pYSEkO6MMDftiLYbV4l2QvFX77hPNm7AdiHDNiFTCC2qxh2dZ77oU4CXf6D7vDXe8Yamd
  runApp( MyApp(screenToShow));
}
