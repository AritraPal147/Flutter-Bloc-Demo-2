import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_demo2/views/email_text_field.dart';
import 'package:flutter_bloc_demo2/views/login_button.dart';
import 'package:flutter_bloc_demo2/views/password_text_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;

  const LoginView(
      this.onLoginTapped,
      {Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Uses the same emailController everywhere due to how flutter hooks work
    final emailController = useTextEditingController();
    // Uses the same passwordController everywhere due to how flutter hooks work
    final passwordController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EmailTextField(emailController: emailController),
          PasswordTextField(passwordController: passwordController),
          LoginButton(
              emailController: emailController,
              passwordController: passwordController,
              onLoginTapped: onLoginTapped,
          ),
        ],
      ),
    );
  }
}
