import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onboarding_project/components/TestFiled.dart';
import 'package:onboarding_project/components/constance/const.dart';
import 'package:onboarding_project/components/defaultButton.dart';
import 'package:onboarding_project/components/nav.dart';
import 'package:onboarding_project/layout/HomeScreen.dart';
import 'package:onboarding_project/login/cubit/login_cubit.dart';
import 'package:onboarding_project/login/register_screen.dart';

import 'package:onboarding_project/network/cacheHelper.dart';

class LoginScreen extends StatelessWidget {
  var FormKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.model.status == true) {
              print(state.model.message);
              print(state.model.data!.token);
              Fluttertoast.showToast(
                msg: state.model.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );

              CacheHelper.saveData(
                key: 'token',
                value: state.model.data!.token,
              ).then((value) {
                token = state.model.data!.token;
                NavPushReplacement(context, HomeScreen());
              });
            } else {
              showToast(msg: state.model.message!, state: ToastStates.ERROR);
            }
            NavPushReplacement(context, HomeScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: FormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Login now to browse our hot offers ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey),
                    ),
                    SizedBox(height: 15),
                    defaultTextFormFiled(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      prefixIcon: Icons.email_outlined,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Email';
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    defaultTextFormFiled(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      onSubmit: (value) {
                        if (FormKey.currentState!.validate()) {
                          LoginCubit.get(context).UserLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      suffixPressed: () {
                        LoginCubit.get(context).onChangePasswordVisibility();
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'password is too short';
                        }
                      },
                      label: 'Password',
                      SuffixData: LoginCubit.get(context).suffix,
                      prefixIcon: Icons.lock_outline,
                      isPassword: LoginCubit.get(context).isPassword,
                    ),
                    SizedBox(height: 15),
                    ConditionalBuilder(
                      condition: state is! LoginLoadingState,
                      builder: (context) => defaultButton(
                          text: 'login',
                          function: () {
                            if (FormKey.currentState!.validate()) {
                              LoginCubit.get(context).UserLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          isUpper: true),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don/t have a account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return RegisterScreen();
                                },
                              ));
                            },
                            child: Text('register'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
