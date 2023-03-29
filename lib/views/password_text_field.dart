import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo2/constants/strings.dart' show enterYourPasswordHere;

class PasswordTextField extends StatelessWidget {
  // Controller is required because we need to send data (email) out of our widget
  // so, it can be done easily if we pass a TextEditingController within our Stateless widget
  final TextEditingController passwordController;

  const PasswordTextField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: true,
      obscuringCharacter: '⬛',
      decoration: const InputDecoration(
        hintText: enterYourPasswordHere,
      ),
    );
  }
}
