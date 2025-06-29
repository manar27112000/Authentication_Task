import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_task/features/login/model/login_model.dart';
import 'package:login_task/features/login/model/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  UserModel? userData;

  TextEditingController phoneController = TextEditingController(


  );
  TextEditingController passwordController = TextEditingController(

  );
  TextEditingController dialCodeController = TextEditingController();
  bool isPasswordHidden = true;
  bool isRememberMe = false;
  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(LoginPasswordVisibilityToggled());
  }

  void toggleRememberMe() {
    isRememberMe = !isRememberMe;
    emit(LoginRememberMeToggled());
  }

  // void login({required String phone, required String password}) async {
  //   emit(LoginLoadingState());
  //
  //   try {
  //     if (phone == '010' && password == '123456') {
  //       emit(LoginSuccessState());
  //       //navigator to profile
  //     } else {
  //       emit(LoginFailureState('رقم الهاتف أو كلمة المرور غير صحيحة'));
  //     }
  //   } catch (e) {
  //     emit(LoginFailureState(e.toString()));
  //   }
  // }



  void signInPostMethod() async {
    emit(LoginLoadingState());
    try {

      if (dialCodeController.text.isEmpty || phoneController.text.isEmpty) {
        print('8888888888888888888888888888888888888888');
        print('phoneController ${phoneController}' );
        print('dialCodeController ${dialCodeController}' );
        emit(LoginFailureState("رقم الهاتف مطلوب بالكامل"));

        return;
      }

      Response response = await Dio().post(
        "https://almonqez-alshamel.com/api/login",

        data: {
          "phone": dialCodeController.text.trim() + phoneController.text.trim(),
          "password": passwordController.text,
        },
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        ),

      );


      if (response.statusCode == 200) {
        final loginModel = LoginModel.fromJson(response.data);
        final prefs = await SharedPreferences.getInstance();

        if (isRememberMe) {
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('access_token', loginModel.accessToken);
          await prefs.setString('user_login_data', jsonEncode(loginModel.toJson()));

        }
        emit(LoginSuccessState(loginModel: loginModel));
      } else {
        final message = response.data['message'] ?? 'فشل تسجيل الدخول، حاول مرة أخرى';
        emit(LoginFailureState(message));
      }
    }
    catch(e){
      if (e is DioError) {
        final response = e.response;

        if (response != null && response.data != null) {
          final message = response.data['message'] ?? 'حدث خطأ أثناء تسجيل الدخول';
          emit(LoginFailureState(message));
        } else {
          emit(LoginFailureState('تعذر الاتصال بالسيرفر'));
        }
      } else {
        emit(LoginFailureState('خطأ غير متوقع: ${e.toString()}'));
      }
    }
  }

  void fetchData()async{
    try{
      Response response = await Dio().get('https://almonqez-alshamel.com/api/login');
      if(response.statusCode == 200){
        List<dynamic> data = response.data;
        LoginModel login = LoginModel.fromJson(response.data);
        emit(LoginSuccessState(loginModel: login));
      }else {
        emit(LoginFailureState('فشل في تحميل البيانات'));
    }}
    catch(e){
        emit(LoginFailureState('حدث خطأ أثناء تحميل البيانات: ${e.toString()}'));
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }


}