import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness 3 in 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: TColor.primaryColor1,
        fontFamily: "Poppins",
      ),
      home: const StartedView(),
    );
  }
}
