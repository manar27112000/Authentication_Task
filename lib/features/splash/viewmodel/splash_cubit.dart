import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:login_task/features/login/view/login_screen.dart';

import '../../../main.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitialState());

  void navigateToLoginWithTimer() {
    emit(SplashLoadingState());
    Timer(
      Duration(seconds: 3),
          () {
            emit(SplashSuccessState());
          }

    );
  }
}
