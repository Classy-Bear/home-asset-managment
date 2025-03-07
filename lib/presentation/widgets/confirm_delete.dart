import 'package:flutter/material.dart';

/// A widget that displays a confirmation dialog for deleting an item.
///
/// This widget shows a dialog with a title, content, and two buttons:
/// - "Cancel": Closes the dialog without deleting the item.
/// - "Delete": Deletes the item and closes the dialog.
class ConfirmDelete extends StatelessWidget {
  /// The context of the widget.
  final BuildContext context;
  /// The callback function to be called when the "Delete" button is pressed.
  final VoidCallback onPressed;

  const ConfirmDelete({
    super.key,
    required this.context,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text(
        'Are you sure you want to delete this? This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
