import 'package:flutter/cupertino.dart';

@immutable
class LoginHandle {
  final String token;

  const LoginHandle({required this.token});

  const LoginHandle.admin() : token = 'admin';

  // Overrides the '==' operator to check if the token of current object is equal to token of
  // other object that is compared to it.
  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  // Overrides the toString() method to return a specific string
  // Used for debugging -> to print the token in the console
  @override
  String toString() => 'LoginHandle (token = $token)';
}

// Enum that holds all the LoginErrors possible -> currently, we have only one
enum LoginErrors {
  invalidHandle
}

@immutable
class Note {
  final String title;

  const Note({
    required this.title,
  });

  @override
  String toString() => 'Note (title = $title)';
}

// Generated an iterable of 3 mock notes
// i -> iterates from 0 to 2 and creates a note with required title
final mockNotes = Iterable.generate(3, (i) => Note(title: 'Note ${i+1}'));
