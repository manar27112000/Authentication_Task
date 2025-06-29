// profile_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:login_task/features/login/model/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserModel? userModel;

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
  Future<void> getUserData() async {
    emit(ProfileLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(ProfileError("لا يوجد توكن"));
        return;
      }

      final response = await Dio().get(
        'https://almonqez-alshamel.com/api/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        userModel = UserModel.fromJson(response.data['data']);
        emit(ProfileLoaded(userModel!));
      } else {
        emit(ProfileError('فشل تحميل البيانات'));
      }
    } catch (e) {
      emit(ProfileError('حدث خطأ: ${e.toString()}'));
    }
  }
}
