import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:logger/logger.dart';
import 'package:login_task/features/home/view/home_screen.dart';
import 'package:login_task/features/profile/view/profile_screen.dart';

import '../viewmodel/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  final cubit = context.watch<LoginCubit>();
    LoginCubit cubit = BlocProvider.of<LoginCubit>(context);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginScreen', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state){
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.loginModel.message ?? 'تم تسجيل الدخول بنجاح'),));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen()));
          }else if (state is LoginFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),));
            print('//////////////////////////////////////////////////');
            print(state.error);

          }
        },
        builder: (context, state) {
         // final cubit = context.watch<LoginCubit>();
          bool isChecked = cubit.isRememberMe;

          return Form(
            key:  _formKey,
            child: Padding(
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
                      controller: cubit.phoneController,
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
                      // onChanged: (phone) {
                      //   context.read<LoginCubit>().updatePhone(
                      //     phone.completeNumber,
                      //   );
                      // },
                      validator: (phone) {
                        if (cubit.dialCodeController.text.isEmpty || cubit.phoneController.text.isEmpty) {
                       return   'Please enter your phone number' ;
                        }
                        if (phone == null || phone.number.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (phone.number.length < 9) {
                          return 'Phone number must be 9 numbers';
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(phone.number)) {
                          return 'Phone number must contain only digits';
                        }
                        return null;
                      },
                     onChanged: (phone){
                        cubit.dialCodeController = TextEditingController(text: phone.countryCode);
                     },

                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 85),

                    TextFormField(
                      controller: cubit.passwordController,
                      obscureText: cubit.isPasswordHidden,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 7) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
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
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: isChecked ? Colors.purple : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: isChecked
                                ? const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14, // تأكدي إن الحجم صغير علشان ما يتعداش الحواف
                              ),
                            )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 8),
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

                        if (_formKey.currentState!.validate()) {
                          cubit.signInPostMethod();
                        }
                        // Logger().i(cubit.dialCodeController.text.toString());
                        // Logger().i(cubit.phoneController.text.toString());
                        // Logger().i(cubit.passwordController.text.toString());
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
