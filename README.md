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
  flutter_smart_exit: ^1.0.0
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

| **Property**              | **Description**                                                                 |
| ------------------------- | ------------------------------------------------------------------------------- |
| `exitType`                | Defines how the exit confirmation will appear (dialog, bottom sheet, SnackBar). |
| `exitMessage`             | The message displayed when asking the user to confirm exiting the app.          |
| `exitMessageStyle`        | Custom `TextStyle` for the exit message.                                        |
| `cancelButtonText`        | Text displayed on the cancel button.                                            |
| `cancelButtonTextStyle`   | Custom text style for the cancel button.                                        |
| `cancelButtonStyle`       | Custom `ButtonStyle` for the cancel button.                                     |
| `exitButtonText`          | Text displayed on the exit button.                                              |
| `exitButtonTextStyle`     | Custom text style for the exit button.                                          |
| `exitButtonStyle`         | Custom `ButtonStyle` for the exit button.                                       |
| `backgroundColor`         | Background color for dialog, bottom sheet, or SnackBar.                         |
| `bottomSheetHeight`       | Optional height for the bottom sheet layout.                                    |
| `backPressExitBottomExit` | Duration (in seconds) before auto-exit on double back press (for SnackBar).     |
| `child`                   | The main widget wrapped by the exit handler.                                    |
| `exitImage`               | Optional image widget displayed in the exit UI (dialog or bottom sheet).        |



## 💡 Example

### Bottom Sheet Exit
```
FlutterSmartExit(
  exitType: ExitType.bottomSheetExit,
  exitMessage: "Do you really want to leave?",
  bottomSheetHeight: 250.0,    ///--> can adjust height with your devices
  exitMessageStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  cancelButtonText: "No",
  exitButtonText: "Yes",
  backgroundColor: Colors.white,
  child: MyHomePage(),
)

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