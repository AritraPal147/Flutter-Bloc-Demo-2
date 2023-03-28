import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_demo2/models.dart';
import 'package:flutter_bloc_demo2/constants/strings.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  // Anything that implements the NotesApiProtocol needs to have a function getNotes with a
  // required parameter loginHandle, which if not present return an iterable of null.
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  });
}

// A concrete implementation of the NotesApiProtocol
@immutable
class NotesApi implements NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) => Future.delayed(
    // Fakes a waiting time for api call, since we are not calling an actual api
    const Duration(seconds: 2),
        // If the loginHandle is equal to the admin loginHandle, then return the mockNotes, else return null
        () => loginHandle == const LoginHandle.admin() ? mockNotes : null,
  );
}