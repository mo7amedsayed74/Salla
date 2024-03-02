import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';

import '../cubits/app_cubit/cubit.dart';
import '../cubits/app_cubit/states.dart';
import 'login_screen.dart';
import '../networks/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state) {
        AppCubit cubit = AppCubit.get(context);
        nameController.text = cubit.profileData!.data!.name!;
        emailController.text = cubit.profileData!.data!.email!;
        phoneController.text = cubit.profileData!.data!.phone!;
        return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if(state is UpdateDataLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      boardType: TextInputType.text,
                      label: 'Name',
                      prefix: Icons.person,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'Name must not be empty';
                        }else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      boardType: TextInputType.emailAddress,
                      label: 'Email',
                      prefix: Icons.email,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'Email must not be empty';
                        }else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      boardType: TextInputType.phone,
                      label: 'Phone',
                      prefix: Icons.phone,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'Phone must not be empty';
                        }else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      text: 'update',
                      onPressedFunction:  (){
                        cubit.updateUserData(
                          data: {
                            'name':nameController.text,
                            'email':emailController.text,
                            'phone':phoneController.text,
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      text: 'signOut',
                      onPressedFunction:  (){
                        CacheHelper.remove(key: 'token',).then((value) {
                          context.navigatePushReplacement( screenToView: LoginScreen(), );
                        },);
                      },
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}
