import 'package:flutter/material.dart';
import 'package:my_chatt_app/services/auth/auth_services.dart';
import 'package:my_chatt_app/components/my_buton.dart';
import 'package:my_chatt_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  // email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  // tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  

  // login method
  void login(BuildContext context) async {
  //auth services
  final authService = AuthService();

  // try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
    }
  //   //catch any errors
    catch (e) {
      showDialog(context: context,
      builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 50),

            // welllcome back welcome back massage
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 25),

            //email text field
            MyTextfield(
              hintText: "Email",
              obsecureText: false,
              controller: _emailController,
            ),
            SizedBox(height: 10),
            //pw textfield
            MyTextfield(
              hintText: "PassWord",
              obsecureText: true,
              controller: _pwController,
            ),
            SizedBox(height: 25),

            //login button
            MyButton(
              text: "LOGIN",
              onTap: () => login(context), //() => login(context)
            ),
            SizedBox(height: 25),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a membar? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Register now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
