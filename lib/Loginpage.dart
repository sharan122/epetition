// ignore_for_file: avoid_print, use_build_context_synchronously, file_names, no_leading_underscores_for_local_identifiers, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_petition_app/Models/LoginModel.dart';
import 'package:mass_petition_app/homepage/homepage.dart';
import 'package:mass_petition_app/registration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

String? userLoginId;
String? LocalBodyId;
String? Name;
int? statuscode;

Future<Login> loginUser(userName, password, fkRoleId) async {
  const String apiUrl = 'http://54.89.172.156/login';

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
      userLoginId = responseData['userLoginId'];
      print(userLoginId);

      LocalBodyId = responseData['fklocalbodyId'];
      Name = responseData['firstName'].toString();
      statuscode = responseData['statusCode'];
      print('StausCode: $statuscode');
      print(Name);
      return Login.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
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

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController usController = TextEditingController();
    TextEditingController lpsController = TextEditingController();
    Login? _login;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            //login
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: GoogleFonts.angkor(
                    color: Colors.white,
                    fontSize: 35,
                  ),
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
            const SizedBox(height: 10),
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
            const Row(
              children: [
                Register(),
              ],
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 248, 247, 247),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(
                    width: 2.0,
                    color: Color.fromARGB(255, 248, 247, 247),
                  ),
                ),
              ),
              onPressed: () async {
                String userName = usController.text;
                String password = lpsController.text;
                String fkRoleId = "6581eabb9e3ba253cc4946cc";
                if (userName.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please enter email and password"),
                    behavior: SnackBarBehavior.floating,
                  ));
                  return; // Stay on the same login page
                }
                try {
                  Login data = await loginUser(userName, password, fkRoleId);

                  setState(() {
                    _login = data;
                  });

                  if (statuscode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Logged in as: $Name"),
                      behavior: SnackBarBehavior.floating,
                    ));
                    // Navigate to home page only if login is successful
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return const Homepage();
                      }),
                    );
                  } else {
                    // Handle login failure (show error message, etc.)
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Invalid email or password"),
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                } catch (e) {
                  // Handle network or other errors
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Error: $e"),
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              },
              child: const Text(
                'LOGIN',
                style: TextStyle(color: Colors.black),
              ),
            )

            //new user?
          ],
        ),
      ),
    );
  }
}
