import 'package:flutter/material.dart';
import 'package:login_task/features/home/view/home_screen.dart';
import 'package:login_task/features/login/view/login_screen.dart';
import 'package:login_task/features/splash/view/splash_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: 'manar');
    TextEditingController phoneController = TextEditingController(text: '01150041361 ',);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Screen ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/23/8e/da/238eda563b69121eb09081070725e8f8.jpg',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Name', style: TextStyle(fontSize: 14)),
              SizedBox(height: MediaQuery.of(context).size.height / 80),
              TextFormField(
            controller: nameController,
            decoration: InputDecoration(

              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              hintText: '',

              hintStyle: TextStyle(color:Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
              SizedBox(height: 20),
              Text('Phone Number', style: TextStyle(fontSize: 14)),
              SizedBox(height: MediaQuery.of(context).size.height / 80),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  hintText: '',
                  hintStyle: TextStyle(color:Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>  HomeScreen(),
                    ),
                  );                },
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: 37,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      gradient:  LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors:  [
                          Color(0xff4E2180),
                          Color(0xff4A2484),
                          Color(0xff452A8A),
                          Color(0xff521E77),
                          Color(0xff5E1468),
                          Color(0xff631163),
                        ],
                      ),
                    ),
                    child:Text('Go to Home',
                      style: TextStyle(fontSize: 18,color: Colors.white),)
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap:() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>  LoginScreen(),
                    ),
                    (route) => false,
                  );                },
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: 37,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      gradient:  LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors:  [
                          Color(0xff4E2180),
                          Color(0xff4A2484),
                          Color(0xff452A8A),
                          Color(0xff521E77),
                          Color(0xff5E1468),
                          Color(0xff631163),
                        ],
                      ),
                    ),
                    child:Text('Logout',
                      style: TextStyle(fontSize: 18,color: Colors.white),)
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
