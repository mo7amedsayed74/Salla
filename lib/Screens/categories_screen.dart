import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';

import '../cubits/app_cubit/cubit.dart';
import '../cubits/app_cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index) => categoriesBuilder(cubit.categoriesModel!.categoriesData!.data![index]),
          separatorBuilder: (context,index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.teal,
            ),
          ),
          itemCount: cubit.categoriesModel!.categoriesData!.data!.length,
        );
      },
    );
  }

  Widget categoriesBuilder(DataModelFromCategories item) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(item.image!),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              item.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }

}
