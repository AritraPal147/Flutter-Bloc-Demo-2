import 'dart:async';

import 'package:flutter/cupertino.dart';
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

  LoadingScreenController? _controller;
  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final _text = StreamController<String>();
    _text.add(text);

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
                  child: null,
                ),
              ),
            ),
          );
        },
    );
  }
}