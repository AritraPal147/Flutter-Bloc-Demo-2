import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo2/apis/notes_api.dart';
import 'package:flutter_bloc_demo2/bloc/app_actions.dart';
import 'package:flutter_bloc_demo2/constants/strings.dart';
import 'package:flutter_bloc_demo2/dialogs/generic_dialog.dart';
import 'package:flutter_bloc_demo2/dialogs/loading_screen.dart';
import 'package:flutter_bloc_demo2/dialogs/loading_screen_controller.dart';
import 'package:flutter_bloc_demo2/models/models.dart';
import 'package:flutter_bloc_demo2/views/iterable_list_view.dart';
import 'package:flutter_bloc_demo2/views/login_view.dart';

import 'apis/login_api.dart';
import 'bloc/app_bloc.dart';
import 'bloc/app_state.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        // Gets implementation (instance) of LoginApi
        loginApi: LoginApi(),
        // Gets implementation (instance) of NotesApi
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          // Basically checks for side effects like displaying overlay (not on widget tree)
          listener: (context, appState) {
            // Loading Screen
            if (appState.isLoading) {
              // If app is in loading state, then show Loading Screen (update if required)
              LoadingScreen.instance().show(
                context: context,
                text: pleaseWait,
              );
            } else {
              // Hide loading screen is not loading
              LoadingScreen.instance().hide();
            }

            // Display Possible Errors
            final loginError = appState.loginError;
            // If there is login error, then show the login error
            if (loginError != null) {
              showGenericDialog(
                  context: context,
                  title: loginErrorDialogTitle,
                  content: loginErrorDialogContent,
                  optionBuilder: () => {ok: true,},
              );
            }

            // If we are logged in and notes are not fetched, then fetch them now
            if (
                appState.isLoading == false &&
                appState.loginError == null &&
                appState.loginHandle == const LoginHandle.admin() &&
                appState.fetchedNotes == null
            ) {
              // Sends the LoadNotesAction to the AppBloc to tell it to start reading the notes
              context.read<AppBloc>().add(
                  const LoadNotesAction(),
              );
            }
          },
          // Builds the UI widget tree
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            // If no notes are fetched
            if (notes == null) {
              // Show Login View and try to log in
              return LoginView(
                    (email, password) {
                      context.read<AppBloc>().add(
                        LoginAction(
                          email: email,
                          password: password,
                        ),
                      );},
              );
            } else {
              // If notes are fetched then display notes in List View
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
