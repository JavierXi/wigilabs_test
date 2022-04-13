import 'package:flutter/material.dart';
import 'package:wigilabs/main_layout/ui/screens/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wigilabs',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MainPageLayout(),
    );
  }
}
