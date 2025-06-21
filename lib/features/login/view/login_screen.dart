import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login_task/features/home/view/home_screen.dart';
import 'package:login_task/features/profile/view/profile_screen.dart';

import '../viewmodel/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  final cubit = context.watch<LoginCubit>();
    LoginCubit cubit = BlocProvider.of<LoginCubit>(context);
    TextEditingController phoneController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginScreen', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
         // final cubit = context.watch<LoginCubit>();
          bool isChecked = cubit.isRememberMe;

          return Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'LOGIN TO YOUR ACCOUNT',
                      style: TextStyle(fontSize: 18),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 70),
                  Text(
                    'Enter Your Login Information',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    maxLines: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 35),
                  IntlPhoneField(
                    controller: phoneController,
                    flagsButtonPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    dropdownIconPosition: IconPosition.trailing,
                    initialCountryCode: 'SA',
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                    ),
                    onChanged: (phone) {
                      context.read<LoginCubit>().updatePhone(
                        phone.completeNumber,
                      );
                    },
                    validator: (phone) {
                      if (phone == null || phone.number.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (phone.number.length < 9) {
                        return 'Phone number must be 9 numbers';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(phone.number)) {
                        return 'Phone number must contain only digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 85),

                  TextFormField(
                    obscureText: context.watch<LoginCubit>().isPasswordHidden,
                    onChanged: (value) {
                      context.read<LoginCubit>().updatePassword(value);
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          context.read<LoginCubit>().isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          context.read<LoginCubit>().togglePasswordVisibility();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 85),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                         cubit.toggleRememberMe();
                        },
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: isChecked ? Colors.purple : Colors.white,
                            // تغيير اللون
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isChecked ? Colors.purple : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child:
                              isChecked
                                  ? Icon(Icons.check, color: Colors.white)
                                  : null,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 40),
                      Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 85),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProfileScreen()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 37,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
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
                      child: Text(
                        'Get Started',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
appbar title
logo
textformfield number
textformfield password
remember me
login button get stared
 */
