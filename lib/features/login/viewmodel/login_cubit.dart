// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'login_state.dart';
//
// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginInitialState());
//
//   String phone = '';
//   String password = '';
//   bool isPasswordHidden = true;
//   bool isRememberMe = false;
//
//   void updatePhone(String value) {
//     phone = value;
//   }
//
//   void updatePassword(String value) {
//     password = value;
//   }
//   void togglePasswordVisibility() {
//     isPasswordHidden = !isPasswordHidden;
//     emit(LoginPasswordVisibilityToggled());
//   }
//   void toggleRememberMe() {
//     isRememberMe = !isRememberMe;
//     emit(LoginRememberMeToggled());
//   }
//   void login({required String phone, required String password}) async {
//     emit(LoginLoadingState());
//
//     try {
//
//       if (phone == '010' && password == '123456') {
//         emit(LoginSuccessState());
//       } else {
//         emit(LoginFailureState('رقم الهاتف أو كلمة المرور غير صحيحة'));
//       }
//
//     } catch (e) {
//       emit(LoginFailureState(e.toString()));
//     }
//   }
// }