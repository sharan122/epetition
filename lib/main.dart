import 'package:flutter/material.dart';
import 'package:mass_petition_app/Loginpage.dart';
import 'package:mass_petition_app/homepage/post_details.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserMessagesProvider()),
        // Add more providers if needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightBlue, highlightColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: const Loginpage(),
    );
  }
}
