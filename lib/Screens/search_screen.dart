import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components.dart';
import '../cubits/search_cubit/search_cubit.dart';
import '../cubits/search_cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final GlobalKey formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 20,
                    ),
                    child: defaultFormField(
                      controller: searchController,
                      boardType: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'Enter any product name to Search';
                        }
                        return null;
                      },
                      onSubmit: (text){
                        cubit.searchProduct(text);
                      },
                    ),
                  ),
                  if(state is SearchLoadingState)
                    const SizedBox(
                      height: 20,
                    ),
                  if(state is SearchLoadingState)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: LinearProgressIndicator(),
                    ),
                  if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => favoritesAndSearchItemsBuilder(cubit.searchModel!.searchDataModel!.data![index], context,isSearch: true,),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.teal,
                          ),
                        ),
                        itemCount: cubit.searchModel!.searchDataModel!.data!.length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
