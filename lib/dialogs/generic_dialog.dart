import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// renamed a function() that returns a map of string and generic type
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionBuilder,
}) {
  final options = optionBuilder();
  return showDialog<T?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        // Every key in the options map is the title of an action
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          // returns a TextButton with the title of the action to be performed
          return TextButton(
            onPressed: () {
              if (value != null) {
                // If not null, then return it to the user
                Navigator.of(context).pop(value);
              } else {
                // If null, then just pop
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}