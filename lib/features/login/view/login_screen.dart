import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login_task/features/home/view/home_screen.dart';

import '../viewmodel/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
  //  final cubit = context.watch<LoginCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('LoginScreen'),backgroundColor: Colors.red,),
      body: Padding(padding:EdgeInsets.all(20),
      child: Column(children: [Padding(
      padding:  EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 100,),
            IntlPhoneField(
              decoration: const InputDecoration(
                labelText: 'رقم الهاتف',
                border: OutlineInputBorder(borderSide: BorderSide()),
              ),
              initialCountryCode: 'EG', // كود الدولة الابتدائي
              onChanged: (phone) {
              //  context.read<LoginCubit>().updatePhone(phone.completeNumber);
              },
            ),
            TextFormField(
            //  obscureText: context.watch<LoginCubit>().isPasswordHidden,
              onChanged: (value) {
           //     context.read<LoginCubit>().updatePassword(value);
              },
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                border: const OutlineInputBorder(),
                // suffixIcon: IconButton(
                //   icon: Icon(
                //     context.read<LoginCubit>().isPasswordHidden
                //         ? Icons.visibility_off
                //         : Icons.visibility,
                //   ),
                //   onPressed: () {
                //  //   context.read<LoginCubit>().togglePasswordVisibility();
                //   },
                // ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                //  value: cubit.isRememberMe,
                  onChanged: (_) {
                 //   cubit.toggleRememberMe();
                  }, value: true,
                ),  const Text(
                  'تذكرني',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // بدون أي تدوير
                  ),
                ),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      )],)
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
