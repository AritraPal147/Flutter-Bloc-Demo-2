import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_demo2/models/models.dart';

// All the app states (outputs) are controlled by this class
@immutable
class AppState {
  // Variable that checks if the app is in loading state or not
  final bool isLoading;
  // Variable for storing loginErrors encountered, if any
  final LoginErrors? loginError;
  // Variable for storing loginHandle, if any
  final LoginHandle? loginHandle;
  // Variable for storing fetched notes, if any
  final Iterable<Note>? fetchedNotes;

  // Creates an empty state to be called when the app starts
  const AppState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        fetchedNotes = null;

  // Constructor for initializing the class
  const AppState({
    required this.isLoading,
    required this.loginError,
    required this. loginHandle,
    required this.fetchedNotes,
  });

  // Overridden toString() function for debugging.
  // Since multiple are present in here, so, a map of all required data is returned as a string
  @override
  String toString() => {
    'loginError' : loginError,
    'loginHandle' : loginHandle,
    'fetchedNotes' : fetchedNotes,
  }.toString();
}