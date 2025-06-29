import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/features/home/view/home_screen.dart';
import 'package:login_task/features/login/view/login_screen.dart';
import 'package:login_task/features/profile/viewmodel/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else if (state is ProfileLoaded) {
            final user = state.userModel;
            final nameController = TextEditingController(text: user.name );
            final phoneController = TextEditingController(text: user.phone) ;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(Uri.encodeFull(user.image)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Name', style: TextStyle(fontSize: 14)),
                    SizedBox(height: MediaQuery.of(context).size.height / 80),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        hintText: '',
                        hintStyle: const TextStyle(color: Colors.purple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                      //  fillColor: isDark ? Colors.grey : Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Phone Number', style: TextStyle(fontSize: 14)),
                    SizedBox(height: MediaQuery.of(context).size.height / 80),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: phoneController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        hintText: '',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      //  fillColor: isDark ? Colors.grey : Colors.blueGrey,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 37,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xff4E2180),
                              Color(0xff4A2484),
                              Color(0xff452A8A),
                              Color(0xff521E77),
                              Color(0xff5E1468),
                              Color(0xff631163),
                            ],
                          ),
                        ),
                        child: const Text(
                          'Go to Home',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', false);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                              (route) => false,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 37,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xff4E2180),
                              Color(0xff4A2484),
                              Color(0xff452A8A),
                              Color(0xff521E77),
                              Color(0xff5E1468),
                              Color(0xff631163),
                            ],
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('لا توجد بيانات حالياً'));
        },
      ),
    );
  }
}
