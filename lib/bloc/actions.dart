import 'package:flutter/cupertino.dart';

// Umbrella class for all the actions (events) that can occur within the app
@immutable
abstract class AppAction {
  const AppAction();
}

// Concrete implementation of AppAction named LoginAction
// Takes care of actions caused / required during login
// Basically says -> Login user with these credentials
@immutable
class LoginAction implements AppAction{
  final String email;
  final String password;

  const LoginAction({
    required this.email,
    required this.password,
  });
}

// Takes care of loading notes when login is successful
@immutable
class LoadNotesAction implements AppAction {
  const LoadNotesAction();
}