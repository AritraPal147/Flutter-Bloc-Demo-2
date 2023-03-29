import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo2/constants/strings.dart';
import 'package:flutter_bloc_demo2/dialogs/generic_dialog.dart';

// Renaming a void Function() having 2 parameters, email and password to OnLoginTapped
typedef OnLoginTapped = void Function(
    String email,
    String password,
    );

// Code for Login Button implementation
class LoginButton extends StatelessWidget {
  // emailController from email text field -> will give us email entered by user
  final TextEditingController emailController;
  // passwordController from password text field -> will give us password entered by user
  final TextEditingController passwordController;
  // A void callback
  final OnLoginTapped onLoginTapped;

  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          final email = emailController.text;
          final password = emailController.text;
          // Checks if either the email or the password fields or both are empty or not
          if (email.isEmpty || password.isEmpty) {
            showGenericDialog(
                context: context,
                // Title and content are taken from strings.dart
                title: emailOrPasswordEmptyDialogTitle,
                content: emailOrPasswordEmptyDescription,
                // Returns a Map<String, T?> Function
                optionBuilder: () => {
                  // Here Map key is ok string (from strings.dart) and true is the value of index ok
                  ok: true,
                },
            );
          } else {
            // If email and password fields are filled, then try to log in
            onLoginTapped(
                email,
                password,
            );
          }
        },
        child: const Text(login),
    );
  }
}
