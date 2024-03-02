import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components.dart';
import '../cubits/app_cubit/cubit.dart';
import '../cubits/app_cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is SuccessChangeFavoritesState){
          if(state.model.status == false){
            showToast(
              msg: state.model.message!,
              state: ToastStates.error,
            );
          }else{
            showToast(
              msg: state.model.message!,
              state: ToastStates.success,
            );
          }
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        bool notEmpty = cubit.favoritesModel!.favoritesDataModel!.data!.isNotEmpty;
        return ConditionalBuilder(
          condition: state is! LoadingGetFavoritesState,
          builder: (context) {
            if (notEmpty) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => favoritesAndSearchItemsBuilder(cubit.favoritesModel!.favoritesDataModel!.data![index].product, context,),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.teal,
                  ),
                ),
                itemCount: cubit.favoritesModel!.favoritesDataModel!.data!.length,
              );
            } else {
              return const Center(
                child: Text(
                  'No Favorites item',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              );
            }
          },
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

}

