import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app&layout/shop_home_layout.dart';

import '../components.dart';
import '../constants.dart';
import '../cubits/app_cubit/cubit.dart';
import '../cubits/register_cubit/register_cubit.dart';
import '../cubits/register_cubit/register_states.dart';
import '../networks/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context,state){
            if (state is RegisterSuccessState) {
              if (state.loginModelToRegister.status!) { // status = true
                token = state.loginModelToRegister.data!.token;
                debugPrint('your token is : $token ');
                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModelToRegister.data!.token,
                ).then((value) {
                  AppCubit.get(context).getUserData();
                  AppCubit.get(context).getFavorites();
                  context.navigatePushReplacement(screenToView: const HomeLayout());
                },);
              } else { // status = false
                showToast(
                  msg: state.loginModelToRegister.message!,
                  state: ToastStates.error,
                );
              }
            }
          },
          builder: (context,state){
            RegisterCubit cubit = RegisterCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: nameController,
                        boardType: TextInputType.text,
                        prefix: Icons.person,
                        label: 'User Name',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        boardType: TextInputType.emailAddress,
                        prefix: Icons.phone,
                        label: 'Phone',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: emailController,
                        boardType: TextInputType.emailAddress,
                        prefix: Icons.email,
                        label: 'Email',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        boardType: TextInputType.emailAddress,
                        prefix: Icons.lock,
                        suffix: cubit.suffix,
                        suffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        label: 'Password',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscure: cubit.hide,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) {
                          return defaultButton(
                            text: 'register',
                            isUpperCase: true,
                            background: defaultColor,
                            onPressedFunction: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          );
                        },
                        fallback: (context) => const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
