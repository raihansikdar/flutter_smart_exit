import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Defines the type of exit confirmation UI.
///
/// - [bottomSheetExit] → Shows a bottom sheet when user attempts to exit.
/// - [popUpExit] → Shows a popup dialog.
/// - [backPressExit] → Shows a SnackBar requiring double back press.
enum ExitType { bottomSheetExit, popUpExit, backPressExit }

/// A customizable widget that intercepts back button presses and shows
/// a confirmation UI (bottom sheet, dialog, or double-tap-to-exit SnackBar).
///
/// Wrap your main screen with [FlutterSmartExit] to enable controlled app exits.
///
/// Example:
/// ```dart
/// FlutterSmartExit(
///   exitType: ExitType.popUpExit,
///   child: HomeScreen(),
/// )
/// ```
class FlutterSmartExit extends StatefulWidget {
  /// Type of exit behavior (bottom sheet, popup, or double back press).
  final ExitType exitType;

  /// Optional image widget to display inside exit popup or bottom sheet.
  final Widget? exitImage;

  /// The exit confirmation message.
  final String? exitMessage;

  /// Custom style for the exit message text.
  final TextStyle? exitMessageStyle;

  /// Text to display on the cancel button.
  final String? cancelButtonText;

  /// Text style for the cancel button.
  final TextStyle? cancelButtonTextStyle;

  /// Custom button style for the cancel button.
  final ButtonStyle? cancelButtonStyle;

  /// Text to display on the exit button.
  final String? exitButtonText;

  /// Text style for the exit button.
  final TextStyle? exitButtonTextStyle;

  /// Custom button style for the exit button.
  final ButtonStyle? exitButtonStyle;

  /// Background color for the popup, bottom sheet, or SnackBar.
  final Color? backgroundColor;

  /// Optional height for the bottom sheet.
  final double? bottomSheetHeight;

  /// Vertical margin for the SnackBar during back press exit.
  final double? backPressExitBottomExit;

  /// The main child widget wrapped by this exit handler.
  final Widget child;

  /// Creates a FlutterSmartExit widget.
  ///
  /// Wrap your main screen with this to enable controlled exit behavior.
  const FlutterSmartExit({
    super.key,
    required this.exitType,
    this.exitImage,
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
    this.backPressExitBottomExit,
    required this.child,
  });

  @override
  State<FlutterSmartExit> createState() => _FlutterSmartExitState();
}

class _FlutterSmartExitState extends State<FlutterSmartExit> {
  /// Controls whether the app should pop/exit.
  bool canPop = false;

  /// Tracks double back press count for SnackBar exit type.
  int backPressCounter = 0;

  /// Timer to reset the double back press counter.
  Timer? backPressTimer;

  @override
  void dispose() {
    /// Cancel any active timer when widget is disposed.
    backPressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, dynamic result) {
        if (canPop) {
          return; // Allow app exit
        } else {
          backPressCounter++;

          if (widget.exitType == ExitType.bottomSheetExit) {
            exitBottomSheet();
          } else if (widget.exitType == ExitType.popUpExit) {
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

  /// Shows a SnackBar prompting user to double-tap back to exit the app.
  void exitSnackBar() {
    final textLength = widget.exitMessage?.length ?? 25;
    const minMargin = 30.0;
    const maxMargin = 110.0;

    double dynamicMargin = (textLength > 30) ? minMargin : maxMargin;

    final snackBar = SnackBar(
      content: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.exitMessage ?? 'Tap again to exit',
            textAlign: TextAlign.center,
            style:
                widget.exitMessageStyle ??
                const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        left: dynamicMargin,
        right: dynamicMargin,
        bottom: widget.backPressExitBottomExit ?? 25.0,
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

  /// Shows a popup dialog asking the user to confirm exit.
  void exitPopUp(Size size) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: widget.backgroundColor ?? Colors.white,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Align(
            alignment: Alignment.center,
            child: Container(
              transform: Matrix4.translationValues(0, -size.height * 0.028, 0),
              width: MediaQuery.of(context).size.width * 0.8,
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
                    child: widget.exitImage ?? const Icon(Icons.error_outline),
                  ),
                  SizedBox(height: size.height * 0.010),
                  Text(
                    widget.exitMessage ?? "Are you ready to exit ?",
                    style:
                        widget.exitMessageStyle ??
                        const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style:
                        widget.cancelButtonStyle ??
                        ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade400,
                            width: size.height * 0.001,
                          ),
                          minimumSize: size.width < 550
                              ? Size(size.width * 0.26, size.height * 0.04)
                              : Size(size.width * 0.025, size.height * 0.050),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      widget.cancelButtonText ?? "Cancel",
                      style:
                          widget.cancelButtonTextStyle ??
                          TextStyle(
                            color: Colors.black,
                            fontSize: size.height * 0.016,
                          ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.025),
                Expanded(
                  child: ElevatedButton(
                    style:
                        widget.exitButtonStyle ??
                        ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: size.width < 550
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
                      style:
                          widget.exitButtonTextStyle ??
                          TextStyle(
                            color: Colors.white,
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.w700,
                          ),
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

  /// Shows a bottom sheet asking the user to confirm app exit.
  void exitBottomSheet() {
    Size size = MediaQuery.sizeOf(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: widget.backgroundColor ?? Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: widget.bottomSheetHeight ?? ((size.width > 550) ? 215 : 175),
          transform: Matrix4.translationValues(0, -size.height * 0.038, 0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: size.width > 550 ? 70 : 50,
                  width: size.width > 550 ? 70 : 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: widget.exitImage ?? const Icon(Icons.error_outline),
                ),
                SizedBox(height: size.width > 550 ? 10 : 15),
                Text(
                  widget.exitMessage ?? "Are you ready to exit ?",
                  style:
                      widget.exitMessageStyle ??
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 550 ? 18 : 24,
                      ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    ElevatedButton(
                      style:
                          widget.cancelButtonStyle ??
                          ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: Colors.grey.shade400,
                              width: size.height * 0.001,
                            ),
                            minimumSize: size.width < 550
                                ? Size(size.width * 0.4, size.height * 0.04)
                                : Size(size.width * 0.25, size.height * 0.050),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        widget.cancelButtonText ?? "Cancel",
                        style:
                            widget.cancelButtonTextStyle ??
                            TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.016,
                            ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.016),
                    ElevatedButton(
                      style:
                          widget.exitButtonStyle ??
                          ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: size.width < 550
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
                        style:
                            widget.exitButtonTextStyle ??
                            TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.016,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
