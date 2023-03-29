import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo2/constants/strings.dart' show enterYourEmailHere;

class EmailTextField extends StatelessWidget {
  // Controller is required because we need to send data (email) out of our widget
  // so, it can be done easily if we pass a TextEditingController within our Stateless widget
  final TextEditingController emailController;

  const EmailTextField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: enterYourEmailHere,
      ),
    );
  }
}
