import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo2/apis/login_api.dart';
import 'package:flutter_bloc_demo2/apis/notes_api.dart';
import 'package:flutter_bloc_demo2/bloc/actions.dart';
import 'package:flutter_bloc_demo2/bloc/app_state.dart';
import 'package:flutter_bloc_demo2/models.dart';
import 'package:flutter_bloc_demo2/strings.dart';

// AppBloc is the bloc for our application, with event (input) as AppAction and state (output) as AppState
class AppBloc extends Bloc<AppAction, AppState> {
  // Instance of loginApiProtocol
  final LoginApiProtocol loginApi;
  // Instance of notesApiProtocol
  final NotesApiProtocol notesApi;
  // Since LoginApiProtocol and NotesApiProtocol are abstract classes, we cannot have an instance of them
  // But, when we create an instance of them, we actually get the user defined concrete implementation of
  // these abstract classes, i.e., we get instances of LoginApi and NotesApi respectively

  // The constructor of AppBloc needs an initial state.
  AppBloc({
    required this.loginApi,
    required this.notesApi,
    // AppState.empty() is used as an initial state for this bloc
  }) : super(const AppState.empty()) {
    // Handles the case if the user wants to login
    // Event is sent to us by the UI layer and in response to that event, we emit a state
    on<LoginAction>((event, emit) async {
      // Start loading
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );

      // Log the user in
      final loginHandle = await loginApi.login(
        // The email sent to us by the UI layer is provided to the instance of LoginApi to log us in
        email: event.email,
        // The password sent to us by the UI layer is provided to the instance of LoginApi to log us in
        password: event.password,
      );
      emit(
        AppState(
          isLoading: false,
          // Checks if the the loginHandle returns null -> if it does, then that means that the
          // email / password combination is incorrect
          loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    // Handles the case that the notes has to be loaded
    on<LoadNotesAction>((event, emit) async {
      emit(
        AppState(
          isLoading: true,
          loginError: null,
          // Since the user is already logged in, we need the loginHandle of the user from the previous state
          // This is accomplished by state.loginHandle
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );
      // Get the loginHandle
      final loginHandle = state.loginHandle;
      // Checks if the loginHandle is correct for us to be able to log in or not
      if (loginHandle != const LoginHandle.admin()) {
        // If the loginHandle is incorrect and we are attempting to load notes, then we emit an error state
        emit(
          AppState(
            isLoading: false,
            loginError: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      } else {
        // gets the notes from the notesApi
        final notes = await notesApi.getNotes(
            loginHandle: loginHandle!,
        );
        // emits a state with loaded notes
        emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: loginHandle,
            fetchedNotes: notes,
          ),
        );
      }
    });
  }
}