import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/services/auth/LoginOrRegister.dart';
import 'package:my_chatt_app/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          

          //user is logged in 
          if (snapShot.hasData) {
            return  HomePage();
          }

          //user is not login
          else{
            return const LoginOrRegister();
          }
        }
      ),
    );
  }  
}
