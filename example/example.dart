import 'package:flutter/material.dart';
import 'package:flutter_smart_exit/flutter_smart_exit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Exit Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Smart Exit'),
    );
  }
}

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
        exitType: ExitType.backPressExit, // Select exit type
        exitImage: Image.asset("gif/exit.gif"), // Add your gif, image or icon
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text('Home Screen', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
