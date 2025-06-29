import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/features/profile/view/profile_screen.dart';
import '../../home/view/home_screen.dart';
import '../../login/view/login_screen.dart';
import '../viewmodel/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..navigateToLoginWithTimer(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccessStateToLogin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ));
          } else if (state is SplashSuccessStateToHome) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen()
                ,
              ));
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Image.network('https://th.bing.com/th/id/OIP.xbIWSWwYquTdha9ihTurWwHaEK?w=279&h=180&c=7&r=0&o=5&pid=1.7'
                    ,  fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
