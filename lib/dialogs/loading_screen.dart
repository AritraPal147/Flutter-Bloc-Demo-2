import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo2/dialogs/loading_screen_controller.dart';

class LoadingScreen {
  // Creates a singleton of LoadingScreen
  LoadingScreen._sharedInstance();
  // Creation of singleton using static field
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  // factory is a constructor that is used when we do not want to return a new instance of the class itself
  // It is used here because only one instance of this class has to be created (singleton)
  factory LoadingScreen.instance() => _shared;

  // Controller variable for the loading screen
  LoadingScreenController? _controller;

  // This function will be called when we need to show overlay
  // This is public function, it will internally call _showOverlay()
  void show({
    required BuildContext context,
    required String text,
  }) {
    // ?? -> if null operator -> checks if given parameter is null or not and executes if null
    // Here it checks if _controller?.update(text) is null or not.
    // If null, takes false (overlay does not need to be updated / is not present on screen)
    // and if not null takes _controller?.update(text) (overlay is already present on screen, so needs to be updated)
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(
          context: context,
          text: text,
      );
    }
  }

  // Hides the overlay
  void hide() {
    // Closes the controller -> closes the textStream and removes the overlay
    // (look for close() function below in the return statement)
    _controller?.close();
    _controller = null;
  }

  // Function to show the overlay on the screen -> to be called internally
  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    // Creates a stream controller of type String
    // To get a stream of this controller, we use textStream.stream
    final textStream = StreamController<String>();
    // Asks stream to send text values as event -> basically adds the text
    // provided to the loading screen to the stream
    textStream.add(text);

    // An overlay state variable
    final state = Overlay.of(context);
    // Finds out the screen size so as to scale the Loading Dialog appropriately
    final renderBox = context.findRenderObject() as RenderBox;
    // Size of overlay based on screen size
    final size = renderBox.size;

    // Actual overlay
    final overlay = OverlayEntry(
        builder: (context) {
          return Material(
            // Color of the background when overlay is displayed
            color: Colors.black.withAlpha(150),
            child: Center(
              child: Container(
                // Adds constraints to the the size of the overlay contents, making it a fixed size.
                // If not specified, the overlay will wrap around the text and if the text is small
                // the overlay will be smaller too.
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.8,
                  maxWidth: size.width * 0.8,
                  minWidth: size.width * 0.5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 20,
                        ),
                        // Builds itself based on the latest snapshot of interaction with
                        // a stream
                        StreamBuilder<String>(
                          // The stream used by this StreamBuilder is the stream
                          // controlled by textStream
                            stream: textStream.stream,
                            // Builds on basis of a context and a
                            // snapshot (result of the stream textStream.stream)
                            builder: (context, snapshot) {
                              // Checks if the stream currently contains data or not
                              if (snapshot.hasData) {
                                // If stream contains data, then show the data as a Text widget
                                return Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                );
                              } else {
                                return Container();
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
    );

    // Insert the overlay into the current state
    state.insert(overlay);

    // Returns a loading screen controller with close() and update() functions
    return LoadingScreenController(
        close: () {
          // closes the textStream
          textStream.close();
          // Removes the overlay since it is no longer required
          overlay.remove();
          return true;
        },
        update: (text) {
          // Adds the text to be updated into the textStream
          // so that it can be changed when required
          textStream.add(text);
          return true;
        },
    );
  }
}