import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_demo2/models/models.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  // Basically creates a protocol for any class that wants to become an api,
  // they can do so by calling the login() method of this protocol and provide an email and a password
  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

// A concrete implementation of LoginApiProtocol
@immutable
class LoginApi implements LoginApiProtocol {
  // // This is used to create a singleton. A singleton is needed because we are only using one login credential
  // const LoginApi._sharedInstance();
  // // Creation of singleton using static field
  // static const LoginApi _shared = LoginApi._sharedInstance();
  // // factory is a constructor that is used when we do not want to return a new instance of the class itself
  // // It is used here because only one instance of this class has to be created (singleton)
  // factory LoginApi.instance() => _shared;
  // // Singleton pattern completed

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) => Future.delayed(
    // Fakes a waiting time for api call, since we are not calling an actual api
    const Duration(seconds: 2),
      () => email == 'admin@email.com' && password == 'admin',
    // Returns a boolean value -> isLoggedIn, if true, we create a login handle admin() and return from
    // login function, else we return null
  ).then((isLoggedIn) => isLoggedIn ? const LoginHandle.admin() : null);
}
