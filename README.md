# Flutter Smart Exit ✨

A Flutter package to handle **smart app exit** with double back press, SnackBar, Popup Dialog, or Bottom Sheet.  
Fully customizable and works with **Material** and **Cupertino** apps.

---

## Features

- 💡 Exit app with double back press.
- 🛎 Show SnackBar, Popup Dialog, or Bottom Sheet before exiting.
- 🎨 Fully customizable:
  - Exit message & text style
  - Button text & style
  - Background color
  - Bottom sheet height
- 📱 Responsive design for different screen sizes.
- ⚡ Works with Material and Cupertino apps.
- ✅ Easy to integrate in any Flutter project.

---


## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_smart_exit: ^1.2.0
```


## 🧩 Getting Started
Simply import the package in your Dart file:

```
import 'package:flutter_smart_exit/flutter_smart_exit.dart';

```

## 🛠 Usage
Wrap your Specific widget with FlutterSmartExit:
```
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FlutterSmartExit(
        exitType: ExitType.bottomSheetExit,    // Select exit type
        exitImage: Image.asset("gif/exit.gif"), // Add your gif, image or icon
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text('Home Screen',style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}

```



## 🔹 Exit Options

| Option            | Behavior                                                                     |
| ----------------- | ---------------------------------------------------------------------------- |
| `backPressExit`   | Exit app after **pressing back twice** within 2 seconds. Shows **SnackBar**. |
| `popUpExit`       | Shows an **AlertDialog** to confirm exit.                                    |
| `bottomSheetExit` | Shows a **BottomSheet** to confirm exit.                                     |


## 🎨 Customization

| **Property**               | **Description**                                                                               |
| -------------------------- | --------------------------------------------------------------------------------------------- |
| `exitType`                 | Determines how the exit confirmation appears (dialog, bottom sheet, or double-back SnackBar). |
| `exitImage`                | Optional widget displayed inside the exit dialog or bottom sheet.                             |
| `exitMessage`              | The confirmation message shown when asking the user to exit the app.                          |
| `exitMessageStyle`         | Custom `TextStyle` applied to the exit confirmation message.                                  |
| `cancelButtonText`         | Text displayed on the cancel button.                                                          |
| `cancelButtonTextStyle`    | Custom `TextStyle` for the cancel button text.                                                |
| `cancelButtonStyle`        | Custom `ButtonStyle` for the cancel button.                                                   |
| `exitButtonText`           | Text displayed on the exit button.                                                            |
| `exitButtonTextStyle`      | Custom `TextStyle` for the exit button text.                                                  |
| `exitButtonStyle`          | Custom `ButtonStyle` for the exit button.                                                     |
| `backgroundColor`          | Background color for the exit dialog, bottom sheet, or SnackBar.                              |
| `bottomSheetHeight`        | Optional custom height for the bottom sheet layout.                                           |
| `backPressExitBottomExit`  | Vertical margin applied to the SnackBar when using the double back press exit behavior.       |
| `imageContainerHeight`     | Height of the container wrapping the exit image.                                              |
| `imageContainerWidth`      | Width of the container wrapping the exit image.                                               |
| `imageContainerDecoration` | Decoration for the image container (e.g., border radius, color, shadows).                     |
| `child`                    | The main widget wrapped by the smart exit handler.                                            |


## 💡 Example

### Bottom Sheet Exit
```
FlutterSmartExit(
  exitType: ExitType.bottomSheetExit,        // Select exit behavior

  // Exit image inside dialog or bottom sheet
  exitImage: Image.asset(
    'assets/exit.png',
    fit: BoxFit.contain,
  ),

  // Exit message and styles
  exitMessage: "Do you really want to leave?",
  exitMessageStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),

  // Cancel button customization
  cancelButtonText: "No",
  cancelButtonTextStyle: TextStyle(
    fontSize: 16,
    color: Colors.red,
  ),
  cancelButtonStyle: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  ),

  // Exit button customization
  exitButtonText: "Yes",
  exitButtonTextStyle: TextStyle(
    fontSize: 16,
    color: Colors.white,
  ),
  exitButtonStyle: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  ),

  // Background color for dialog, bottom sheet, or snackbar
  backgroundColor: Colors.white,

  // Bottom sheet customization
  bottomSheetHeight: 250.0,    // Adjust height based on device

  // SnackBar double-back press margin
  backPressExitBottomExit: 20.0,   // Vertical margin for SnackBar

  // Image container customization
  imageContainerHeight: 50,
  imageContainerWidth: 50,
  imageContainerDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.grey.shade200,
  ),

  // Main child widget
  child: MyHomePage(),
);


```

### Bottom PopUp Exit


```
FlutterSmartExit(
  exitType: ExitType.popUpExit,
  exitMessage: "Do you really want to leave?",
  exitMessageStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  cancelButtonText: "No",
  exitButtonText: "Yes",
  backgroundColor: Colors.white,
  child: MyHomePage(),
)

```

### Back Press Exit


```
FlutterSmartExit(
  exitType: ExitType.backPressExit,
  exitMessage: "Do you really want to leave?",
)

```

## Screenshot

![flutter_smart_exit](https://github.com/raihansikdar/flutter_smart_exit/blob/main/assets/bottom_sheet.gif?raw=true)
![flutter_smart_exit](https://github.com/raihansikdar/flutter_smart_exit/blob/main/assets/pop_up.gif?raw=true)
![flutter_smart_exit](https://github.com/raihansikdar/flutter_smart_exit/blob/main/assets/backpress_exit.png?raw=true)


## ✅ Gif Download link:
### Preview
![exit gif](https://raw.githubusercontent.com/raihansikdar/flutter_smart_exit/main/gif/exit.gif)

### Download
[➡️ Click here to download exit.gif](https://raw.githubusercontent.com/raihansikdar/flutter_smart_exit/main/gif/exit.gif)

## ⚠️ Notes

- Make sure FlutterSmartExit wraps the root widget.

- Works with MaterialApp or CupertinoApp.

- SnackBar duration for double back press is 2 seconds (fixed).

##  👨‍💻 Author
**Raihan Sikdar**

Website: [raihansikdar.com](https://raihansikdar.com)  
Email: raihansikdar10@gmail.com  
GitHub: [raihansikdar](https://github.com/raihansikdar)  
LinkedIn: [raihansikdar](https://www.linkedin.com/in/raihansikdar/)

## 🤝 Contributing

Contributions are welcome!
Feel free to open issues or submit pull requests to improve this package.

## 📄 License

This project is licensed under the [MIT License](https://github.com/raihansikdar/flutter_smart_exit/blob/main/LICENSE).