// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_project/components/constance/const.dart';
import 'package:onboarding_project/login/cubit/endPoint.dart';
import 'package:onboarding_project/model_shop_app/model_shop.dart';
import 'package:onboarding_project/network/dio.dart';
import 'package:flutter/material.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;
  void UserLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      // print(loginModel.message);
      // print(loginModel.status);

      // print(loginModel.data!.token.toString());

      //  print(value.data.toString());
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(loginModel.message);
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  onChangePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibility());
  }
}
