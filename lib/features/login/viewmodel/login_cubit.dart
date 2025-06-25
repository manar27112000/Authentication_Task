import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_task/features/login/model/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
      Response response = await Dio().post(
        "https://almonqez-alshamel.com/api/login",
        data: {
          "phone": dialCodeController.text + phoneController.text,
          "password": passwordController.text,
        },
      );

      if (dialCodeController.text.isEmpty || phoneController.text.isEmpty) {
        emit(LoginFailureState("رقم الهاتف مطلوب بالكامل"));
        return;
      }
      if (response.statusCode == 200) {
        final loginModel = LoginModel.fromJson(response.data);

        emit(LoginSuccessState(loginModel: loginModel));
      } else {
        emit(LoginFailureState("Login failed: ${response.data}"));
      }
    }
    catch(e){
      emit(LoginFailureState(e.toString()));
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

}