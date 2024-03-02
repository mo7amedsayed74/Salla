import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/networks/local/cache_helper.dart';
import 'package:shop_app/app&layout/shop_home_layout.dart';

import '../cubits/app_cubit/cubit.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../cubits/login_cubit/login_states.dart';
import 'register_screen.dart';
import '../constants.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) { // status = true
              token = state.loginModel.data!.token;
              //debugPrint('your token is : $token ');
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                AppCubit.get(context).getUserData();
                AppCubit.get(context).getFavorites();
                AppCubit.get(context).getCategories();
                AppCubit.get(context).getNewProducts();
                AppCubit.get(context).currentIndex=0;

                context.navigatePushReplacement(screenToView: const HomeLayout());
              },);
            } else { // status = false
              showToast(
                msg: state.loginModel.message!,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
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
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultFormField(
                        controller: emailController,
                        boardType: TextInputType.emailAddress,
                        prefix: Icons.email,
                        label: 'Email',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'email must not be empty';
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
                        suffix: loginCubit.suffix,
                        suffixPressed: () {
                          loginCubit.changePasswordVisibility();
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            loginCubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        label: 'Password',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'password must not be empty';
                          }
                          return null;
                        },
                        obscure: loginCubit.hide,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) {
                          return defaultButton(
                            text: 'login',
                            isUpperCase: true,
                            background: defaultColor,
                            onPressedFunction: () {
                              //print(emailController.text);
                              if (formKey.currentState!.validate()) {
                                loginCubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          );
                        },
                        fallback: (context) => const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ? ',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          TextButton(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.teal[400],
                              ),
                            ),
                            onPressed: () {
                              context.navigatePush( // using extension
                                  screenToView: RegisterScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
