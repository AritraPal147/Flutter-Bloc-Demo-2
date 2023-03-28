import 'package:flutter/cupertino.dart';

// Renames a boolean function
typedef CloseLoadingScreen = bool Function();
// Renames a boolean function with a string parameter
typedef UpdateLoadingScreen = bool Function(String text);

// Returns a token given by the loading screen itself internally when we call
// show() or hide() methods from outside
// Basically, this will be used to display a loading screen, which, on any change will not
// hide itself and then again start, instead, it will use the update function to change the
// display text and keep on running when required. 
@immutable
class LoadingScreenController {
  // Instance of CloseLoadingScreen function
  final CloseLoadingScreen close;
  // Instance of UpdateLoadingScreen function
  final UpdateLoadingScreen update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}