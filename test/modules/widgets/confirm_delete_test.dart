import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_asset_managment/presentation/widgets/confirm_delete.dart';

void main() {
  group('ConfirmDelete', () {
    testWidgets(
      'renders correctly with all elements',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (BuildContext context) {
                return Scaffold(
                  body: Center(
                    child: ConfirmDelete(
                      context: context,
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
          ),
        );

        // Verify the dialog title
        expect(find.text('Confirm Delete'), findsOneWidget);

        // Verify the dialog content
        expect(
          find.text(
            'Are you sure you want to delete this? This action cannot be undone.',
          ),
          findsOneWidget,
        );

        // Verify action buttons
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
      },
    );

    testWidgets(
      'pressing Delete button calls onPressed callback and closes dialog',
      (WidgetTester tester) async {
        bool deletePressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (BuildContext context) {
                return Scaffold(
                  body: Center(
                    child: ConfirmDelete(
                      context: context,
                      onPressed: () {
                        deletePressed = true;
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );

        // Initial state
        expect(deletePressed, isFalse);

        // Tap the delete button
        await tester.tap(find.text('Delete'));
        await tester.pumpAndSettle();

        // Verify callback was called
        expect(deletePressed, isTrue);
      },
    );

    testWidgets(
      'pressing Cancel button closes dialog without calling onPressed',
      (WidgetTester tester) async {
        bool deletePressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (BuildContext context) {
                return Scaffold(
                  body: Center(
                    child: ConfirmDelete(
                      context: context,
                      onPressed: () {
                        deletePressed = true;
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );

        // Initial state
        expect(deletePressed, isFalse);

        // Tap the cancel button
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        // Verify callback was not called
        expect(deletePressed, isFalse);
      },
    );
  });
}
