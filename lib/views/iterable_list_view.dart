import 'package:flutter/material.dart';

// Basically this extension will call IterableListView() on an iterable whenever toListView is
// called on an iterable, so, it enables simple conversion from Iterable to ListView
extension ToListView<T> on Iterable<T> {
  Widget toListView() => IterableListView(iterable: this);
}

// Converts a given iterable into a listView
class IterableListView<T> extends StatelessWidget {
  final Iterable<T> iterable;
  const IterableListView({
    Key? key,
    required this.iterable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Creates a scrollable, linear array of widgets
    return ListView.builder(
      // Number of elements in listview is equal to length of iterable
      // If not specified, we will get infinite items
        itemCount: iterable.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.list),
            // Title of each element of the listview is the element at index converted to String
            title: Text(
                iterable.elementAt(index).toString(),
            ),
            trailing: const Icon(Icons.check),
          );
        },
    );
  }
}
