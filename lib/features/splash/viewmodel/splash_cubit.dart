import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitialState());
  bool isLoggedIn = false;

  /*void navigateToLoginWithTimer( )  {
    emit(SplashLoadingState());

    Timer(
      Duration(seconds: 3),
          ()async {
            isLoggedIn = await checkIfUserLoggedIn();

            if (isLoggedIn) {
              emit(SplashSuccessStateToHome());

            } else {
              emit(SplashSuccessStateToLogin());
            }          }
    );
  }*/
  void navigateToLoginWithTimer() async {
    emit(SplashLoadingState());

    await Future.delayed(const Duration(seconds: 3));

    isLoggedIn = await checkIfUserLoggedIn();

    if (isLoggedIn) {
      emit(SplashSuccessStateToHome());
    } else {
      emit(SplashSuccessStateToLogin());
    }
  }


  Future<bool> checkIfUserLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isLoggedIn') ?? false;
    } catch (e) {
      print("SharedPreferences error: $e");
      return false;
    }
  }


}
