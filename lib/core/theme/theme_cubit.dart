import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../cache_helper.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  bool isDark = false;
  void changeTheme(bool ?isDarkFromShared){
    if(isDarkFromShared != null) {
      isDark = isDarkFromShared;
      emit(ThemeInitial());
    }
    else{
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(ThemeInitial());
  });}}

}
