import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/core/cache_helper.dart';
import 'package:login_task/core/my_bloc_observer.dart';
import 'package:login_task/core/theme/theme_cubit.dart';
import 'package:login_task/features/home/view/home_screen.dart';
import 'package:login_task/features/login/viewmodel/login_cubit.dart';

import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'features/home/viewmodel/home_cubit.dart';
import 'features/splash/view/splash_screen.dart';
import 'features/splash/viewmodel/splash_cubit.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
    await CacheHelper.init();
    bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  runApp( MyApp( isDark, ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
   MyApp( this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(create: (_) => SplashCubit()),
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()..changeTheme(isDark)),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final themeCubit = BlocProvider.of<ThemeCubit>(context);

          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Login Task App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
