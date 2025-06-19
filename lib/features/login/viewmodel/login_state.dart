part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;
  LoginFailureState(this.error);
}
class LoginPasswordVisibilityToggled extends LoginState {}

class LoginRememberMeToggled extends LoginState {}