// ignore_for_file: avoid_print, use_build_context_synchronously, file_names, no_leading_underscores_for_local_identifiers, unused_local_variable, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mass_petition_app/GR/GRHomePage.dart';
import 'package:mass_petition_app/Models/GRLoginModel.dart';
import 'package:http/http.dart' as http;

class GRLoginpage extends StatefulWidget {
  const GRLoginpage({super.key});

  @override
  State<GRLoginpage> createState() => _GRLoginpageState();
}

Future<Grlogin> Grloginuser(userName, password, fkRoleId) async {
  const String apiUrl = 'http://54.89.172.156/greplogin';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userName': userName.toString(),
        'password': password.toString(),
        'fkRoleId': fkRoleId
      }),
    );
    var data = response.body;
    print(data);
    if (response.statusCode == 200) {
      // Handle successful login
      final Map<String, dynamic> responseData = json.decode(response.body);
      return Grlogin.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // Handle login failure
      print('Login failed: ${response.statusCode}');
      throw Exception("login failed");
    }
  } catch (e) {
    // Handle network or other errors
    print('Error: $e');
    throw Exception("login failed");
  }
}

class _GRLoginpageState extends State<GRLoginpage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController usController = TextEditingController();
    TextEditingController lpsController = TextEditingController();
    Grlogin? _grlogin;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            //login
            const Padding(
              padding: EdgeInsets.only(top: 90),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: usController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: lpsController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                String userName = usController.text;
                String password = lpsController.text;
                String fkRoleId = "6581eabb9e3ba253cc4946cb";
                try {
                  Grlogin data =
                      await Grloginuser(userName, password, fkRoleId);

                  setState(() {
                    _grlogin = data;
                  });

                  if (_grlogin != null) {
                    // Navigate to home page if login is successful
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return const GRHome();
                      }),
                    );
                  } else {
                    // Handle login failure (show error message, etc.)
                    print('Login failed');
                  }
                } catch (e) {
                  // Handle network or other errors
                  print('Error: $e');
                }
              },
              child: const Text('LOGIN'),
            )

            //new user?
          ],
        ),
      ),
    );
  }
}
