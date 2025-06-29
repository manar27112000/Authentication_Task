// profile_state.dart
part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel userModel;

  ProfileLoaded(this.userModel);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
