import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/app_cubit/cubit.dart';
import '../themes.dart';

class MyApp extends StatelessWidget {
  final Widget screenToShow;

  const MyApp(this.screenToShow,{Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return AppCubit()..getNewProducts()..getCategories()..getFavorites()..getUserData();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme, // into 'themes.dart'
        darkTheme: darkTheme, // into 'themes.dart'
        themeMode: ThemeMode.light,
        //themeMode: NewsAppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
        home: screenToShow,
      ),
    );
  }
}
