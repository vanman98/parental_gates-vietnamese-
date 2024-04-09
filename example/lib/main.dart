import 'package:flutter/material.dart';
import 'package:parental_gates/parental_gates.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Center(
              child: ElevatedButton(
            child: const Text("Permission"),
            onPressed: () {
              Permission.getPermission(
                context: context,
                onSuccess: () {
                  print("True");
                },
                onFail: () {
                  print("false");
                },
              );
            },
          )),
        ));
  }
}
