import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_smart_exit/flutter_smart_exit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterSmartExit Tests', () {

    testWidgets('renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterSmartExit(
            exitOption: ExitOption.backPressExit,
            child: const Scaffold(body: Text('Home Page')),
          ),
        ),
      );

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('shows snackbar on first back press (backPressExit)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterSmartExit(
            exitOption: ExitOption.backPressExit,
            exitMessage: 'Press back again to exit',
            child: const Scaffold(body: Text('Home Page')),
          ),
        ),
      );

      // Simulate back button
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Press back again to exit'), findsOneWidget);
    });

    testWidgets('shows popup dialog on back press (popUpExit)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterSmartExit(
            exitOption: ExitOption.popUpExit,
            exitMessage: 'Do you really want to exit?',
            child: const Scaffold(body: Text('Home Page')),
          ),
        ),
      );

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Do you really want to exit?'), findsOneWidget);
    });

    testWidgets('shows bottom sheet on back press (bottomSheetExit)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterSmartExit(
            exitOption: ExitOption.bottomSheetExit,
            exitMessage: 'Exit App?',
            child: const Scaffold(body: Text('Home Page')),
          ),
        ),
      );

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('Exit App?'), findsOneWidget);
    });

    testWidgets('cancel button closes popup dialog',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterSmartExit(
            exitOption: ExitOption.popUpExit,
            child: const Scaffold(body: Text('Home Page')),
          ),
        ),
      );

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });

  });
}
