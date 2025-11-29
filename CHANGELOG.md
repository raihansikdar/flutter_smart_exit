# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2025-11-29

### Added
- Initial release of the `flutter_smart_exit` package.
- `FlutterSmartExit` widget to handle smart exit behaviors in Flutter apps:
  - **Back Press Exit**: Exits the app when the back button is pressed twice within 2 seconds.
  - **Popup Exit**: Displays an alert dialog asking the user to confirm exit.
  - **Bottom Sheet Exit**: Displays a modal bottom sheet asking the user to confirm exit.
- Customizable UI options:
  - `exitMessage` and `exitMessageStyle` for messages.
  - `cancelButtonText`, `exitButtonText`, and their respective styles and button styles.
  - `backgroundColor` for dialogs, bottom sheets, and snackbars.
  - `bottomSheetHeight` for custom bottom sheet height.
- Automatically handles back press counting and timer reset.
- SnackBar support for user-friendly back press notifications.
- Responsive and adaptive layout for different screen sizes.

### Fixed
- N/A (first release)

### Notes
- Ensure to wrap your app with a `MaterialApp` or `CupertinoApp` when using this widget.
- Works with Flutter's `SystemNavigator.pop()` to exit the app.
- All dialogs, snackbars, and bottom sheets are fully customizable.
