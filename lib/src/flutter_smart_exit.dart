import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Defines the type of exit option behavior.
///
/// - [bottomSheetExit] → Shows a modal bottom sheet asking user to exit.
/// - [popUpExit] → Shows an alert dialog asking user to exit.
/// - [backPressExit] → Exits app after pressing back twice within 2 seconds.
enum ExitOption { bottomSheetExit, popUpExit, backPressExit }

/// A customizable widget that provides a smart exit feature for Flutter apps.
///
/// This widget intercepts the back button press and displays an exit confirmation
/// dialog, bottom sheet, or snack bar depending on the selected [exitOption].
///
/// Example:
/// ```dart
/// FlutterSmartExit(
///   exitOption: ExitOption.popUpExit,
///   exitMessage: "Do you really want to exit?",
///   child: MyHomePage(),
/// )
/// ```
class FlutterSmartExit extends StatefulWidget {
  /// Defines which exit confirmation style to use.
  final ExitOption exitOption;

  /// Message displayed to the user when confirming exit.
  final String? exitMessage;

  /// Custom style for the exit confirmation message.
  final TextStyle? exitMessageStyle;

  /// Text for the cancel button.
  final String? cancelButtonText;

  /// Custom style for the cancel button text.
  final TextStyle? cancelButtonTextStyle;

  /// Custom button style for the cancel button.
  final ButtonStyle? cancelButtonStyle;

  /// Text for the exit/confirm button.
  final String? exitButtonText;

  /// Custom style for the exit button text.
  final TextStyle? exitButtonTextStyle;

  /// Custom button style for the exit button.
  final ButtonStyle? exitButtonStyle;

  /// Background color of dialog/bottom sheet/snackbar.
  final Color? backgroundColor;

  /// Custom height for the bottom sheet (only applies when using [ExitOption.bottomSheetExit]).
  final double? bottomSheetHeight;

  /// The main content of your application.
  final Widget child;

  /// Creates a [FlutterSmartExit] widget.
  ///
  /// The [exitOption] and [child] parameters are required.
  const FlutterSmartExit({
    super.key,
    required this.exitOption,
    this.exitMessage,
    this.exitMessageStyle,
    this.cancelButtonText,
    this.cancelButtonTextStyle,
    this.cancelButtonStyle,
    this.exitButtonText,
    this.exitButtonTextStyle,
    this.exitButtonStyle,
    this.backgroundColor,
    this.bottomSheetHeight,
    required this.child,
  });

  @override
  State<FlutterSmartExit> createState() => _FlutterSmartExitState();
}

class _FlutterSmartExitState extends State<FlutterSmartExit> {
  bool canPop = false;
  int backPressCounter = 0;
  Timer? backPressTimer;

  @override
  void dispose() {
    backPressTimer?.cancel(); // Cancel any pending timer
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, dynamic) {
        if (canPop) {
          return;
        } else {
          backPressCounter++;

          if (widget.exitOption == ExitOption.bottomSheetExit) {
            exitBottomSheet();
          } else if (widget.exitOption == ExitOption.popUpExit) {
            exitPopUp(size);
          } else if (backPressCounter == 2) {
            canPop = true;
            SystemNavigator.pop();
          } else {
            backPressTimer?.cancel();
            backPressTimer = Timer(const Duration(seconds: 2), () {
              backPressCounter = 0;
            });
            exitSnackBar();
          }
        }
      },
      child: widget.child,
    );
  }

  /// Displays a popup alert dialog asking the user to confirm exit.
  void exitPopUp(Size size) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: widget.backgroundColor ?? Colors.white,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Align(
            alignment: Alignment.center,
            child: Container(
              transform: Matrix4.translationValues(0, -size.height * 0.028, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Image.asset(
                      "gif/exit.gif",
                      package: "flutter_smart_exit",
                      height: size.height * 0.045,
                    ),
                  ),
                  SizedBox(height: size.height * 0.010),
                  Text(
                    widget.exitMessage ?? "Are you ready to exit ?",
                    style: widget.exitMessageStyle ??
                        TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.grey.shade500,
                        ),
                  ),
                ],
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: widget.cancelButtonStyle ??
                      ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.grey.shade400,
                          width: size.height * 0.001,
                        ),
                        minimumSize: size.width < 600
                            ? Size(size.width * 0.26, size.height * 0.04)
                            : Size(size.width * 0.025, size.height * 0.050),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    widget.cancelButtonText ?? "Cancel",
                    style: widget.cancelButtonTextStyle ??
                        TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.016,
                        ),
                  ),
                ),
                SizedBox(width: size.width * 0.016),
                ElevatedButton(
                  style: widget.exitButtonStyle ??
                      ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        side: BorderSide.none,
                        minimumSize: size.width < 600
                            ? Size(size.width * 0.26, size.height * 0.04)
                            : Size(size.width * 0.025, size.height * 0.050),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                  onPressed: () async {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    widget.exitButtonText ?? "Exit",
                    style: widget.exitButtonTextStyle ??
                        TextStyle(
                          color: Colors.white,
                          fontSize: size.height * 0.016,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Displays a snackbar message prompting the user to press back again to exit.
  void exitSnackBar() {
    final textLength = widget.exitMessage?.length ?? 25;
    const minMargin = 45.0;
    const maxMargin = 110.0;

    double dynamicMargin =
        (textLength > 30) ? minMargin : maxMargin; // Adjust margin

    final snackBar = SnackBar(
      content: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.exitMessage ?? 'Press back again to exit',
            textAlign: TextAlign.center,
            style: widget.exitMessageStyle ??
                const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        left: dynamicMargin,
        right: dynamicMargin,
        bottom: 30.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 8.0),
      backgroundColor: widget.backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          dynamicMargin == minMargin ? 50 : 20.0,
        ),
      ),
      elevation: 8.0,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Displays a bottom sheet asking the user to confirm exit.
  void exitBottomSheet() {
    Size size = MediaQuery.sizeOf(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        backgroundColor: widget.backgroundColor ?? Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: widget.bottomSheetHeight ??
                (size.width > 500 ? 215 : 175),
            transform: Matrix4.translationValues(0, -size.height * 0.040, 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: size.width > 500 ? 70 : 50,
                    width: size.width > 500 ? 70 : 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Image.asset(
                      "gif/exit.gif",
                      package: "flutter_smart_exit",
                      height: size.width > 500
                          ? size.height * 0.080
                          : size.height * 0.045,
                    ),
                  ),
                  SizedBox(height: size.width > 500 ? 10 : 20),
                  Text(
                    widget.exitMessage ?? "Are you ready to exit ?",
                    style: widget.exitMessageStyle ??
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width < 500 ? 18 : 24,
                        ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: widget.cancelButtonStyle ??
                            ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: Colors.grey.shade400,
                                width: size.height * 0.001,
                              ),
                              minimumSize: size.width < 500
                                  ? Size(size.width * 0.4, size.height * 0.04)
                                  : Size(size.width * 0.25, size.height * 0.050),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          widget.cancelButtonText ?? "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.height * 0.016,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.016),
                      ElevatedButton(
                        style: widget.exitButtonStyle ??
                            ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              side: BorderSide.none,
                              minimumSize: size.width < 500
                                  ? Size(size.width * 0.4, size.height * 0.04)
                                  : Size(size.width * 0.25, size.height * 0.050),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                        onPressed: () async {
                          SystemNavigator.pop();
                        },
                        child: Text(
                          widget.exitButtonText ?? "Exit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
