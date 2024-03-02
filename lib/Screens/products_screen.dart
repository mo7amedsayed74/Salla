import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

import '../cubits/app_cubit/cubit.dart';
import '../cubits/app_cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);


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
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null ,
          builder: (context) => productsScreenBuilder(cubit.homeModel,cubit.categoriesModel,cubit),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsScreenBuilder(HomeModel? homeModel,CategoriesModel? categoriesModel,AppCubit cubit) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: homeModel!.data!.banners!.map( (e) {
                      return Image(
                        image: NetworkImage('${e.image}',),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },).toList(),
                  options: CarouselOptions(
                    height: 200.0,
                    initialPage: 0,
                    viewportFraction: 1, // from 0.1 to 1
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) => stackCategoriesBuilder(categoriesModel!.categoriesData!.data![index]),
                    separatorBuilder: (context,index) => const SizedBox(width: 8,),
                    itemCount: categoriesModel!.categoriesData!.data!.length,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.58 , // width / height
              children: List.generate(
                homeModel.data!.products!.length,
                (index){
                  return productItem(homeModel.data!.products![index],cubit);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget stackCategoriesBuilder(DataModelFromCategories item){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(item.image!),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.teal.withOpacity(0.8),
          width: 100.0,
          child: Text(
            item.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget productItem(ProductsModel item,AppCubit cubit){
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(item.image!),
                height: 150.0,
                width: double.infinity,
              ),
              if(item.discount != 0)
                Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            item.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.0,
              height: 1.2,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.price.round()}',
                    style: TextStyle(
                      color: Colors.teal[300],
                    ),
                  ),
                  if(item.discount != 0)
                    Text(
                      '${item.oldPrice.round()}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: (){
                  cubit.changeFavorites(item.id!);
                },
                icon: CircleAvatar(
                  backgroundColor: (cubit.favorites[item.id]!) ? defaultColor : Colors.grey[350],
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
