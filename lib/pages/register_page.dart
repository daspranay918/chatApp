import 'package:flutter/material.dart';
import 'package:my_chatt_app/services/auth/auth_services.dart';
import 'package:my_chatt_app/components/my_buton.dart';
import 'package:my_chatt_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  // email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmpwController = TextEditingController();
  //tap to go to Registe Page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // register method
  void register(BuildContext context) {
    // get auth service
    final  _auth = AuthService();
    //passwords match -> create user
   
    if (_pwController.text == _confirmpwController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
    // password dont match -> show error to the user to fix
    else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("Password don't match!")),
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
              "Let's create an account for you",
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
            SizedBox(height: 10),
            MyTextfield(
              hintText: "Confirm PassWord",
              obsecureText: true,
              controller: _confirmpwController,
            ),
            SizedBox(height: 25),

            //login button
            MyButton(text: "REGISTER", onTap: () => register(context)),
            SizedBox(height: 25),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Login Now",
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
