part of 'splash_cubit.dart';

abstract class SplashState {}

final class SplashInitialState extends SplashState {}
final class SplashLoadingState extends SplashState {}
final class SplashSuccessStateToLogin extends SplashState {}
final class SplashSuccessStateToHome extends SplashState {}
