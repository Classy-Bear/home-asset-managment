import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  final BuildContext context;
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
