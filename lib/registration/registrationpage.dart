// ignore_for_file: unused_field, avoid_print, non_constant_identifier_names, use_build_context_synchronously

// import 'dart:js_interop';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:mass_petition_app/Loginpage.dart';

import 'package:mass_petition_app/Models/SignUpModel.dart';

import '../Models/LocalBodyModel.dart';
// import 'package:mass_petition_app/password.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

// handling api end point
Future<Signup> submitData(
    firstName,
    lastName,
    password,
    email,
    address,
    pincode,
    district,
    localbodyName,
    fkRoleId,
    fklocalbodyId,
    fklocalbodyTypeId,
    phone) async {
  const String apiUrl = 'http://54.89.172.156/signup';
  try {
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "password": password,
          "email": email,
          "address": address,
          "pincode": pincode,
          "district": district,
          "localbodyName": localbodyName,
          "fkRoleId": fkRoleId,
          "fklocalbodyId": fklocalbodyId.id.toString(),
          "fklocalbodyTypeId": fklocalbodyTypeId,
          "phone": phone
        }));
    var data = response.body;
    print(data);
    if (response.statusCode == 200) {
      return Signup.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      print("HTTP error: ${response.statusCode}");
      throw Exception("failed to create user");
    }
  } catch (e) {
    print("Exception: $e");
    throw Exception("Failed to create user");
  }
}

Future<Localbody> fetchLocalbodies() async {
  final response = await http.get(Uri.parse(
      'http://54.89.172.156/list_localbody')); // Replace with your actual API endpoint

  if (response.statusCode == 200) {
    return Localbody.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load localbodies');
  }
}

class _RegistrationState extends State<Registration> {
  List<LocalbodyElement>? localbodies;
  LocalbodyElement? selectedValue;
  Signup? _signup;
  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController psController = TextEditingController();
  // TextEditingController cpsController = TextEditingController();
  TextEditingController phController = TextEditingController();
  TextEditingController emController = TextEditingController();
  TextEditingController adController = TextEditingController();
  TextEditingController dsController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController lbcontroller = TextEditingController();
  String? localbody;

// signup ui
  @override
  void initState() {
    super.initState();
    fetchLocalbodies().then((data) {
      setState(() {
        localbodies = data.localbody;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'REGISTER',
                style: GoogleFonts.angkor(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 20),
                  child: TextField(
                    controller: fnController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: TextField(
                      controller: lnController,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: 'Last Name',
                          hintStyle: TextStyle(color: Colors.white)),
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 26, top: 10),
            child: TextField(
                controller: emController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                controller: adController,
                maxLines: 5,
                maxLength: 300,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Address',
                    hintStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 26, top: 10),
            child: TextField(
                controller: phController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 26, top: 10),
            child: TextField(
                maxLength: 6,
                controller: pinController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'pincode',
                    hintStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 26, top: 3),
            child: TextField(
                controller: dsController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'District',
                    hintStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 26, top: 3),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white, width: 1)),
              child: DropdownButton<LocalbodyElement>(
                dropdownColor: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                isExpanded: true,
                value: selectedValue,
                hint: const Text('Select a localbody',
                    style: TextStyle(color: Colors.white)),
                onChanged: (LocalbodyElement? newValue) {
                  setState(() {
                    selectedValue = newValue;
                    // Add your logic here when an item is selected
                    if (selectedValue != null) {
                      print(
                          'Selected Localbody: ${selectedValue!.localbodyName}');
                      // Add your database storage logic here
                    }
                  });
                },
                items: localbodies?.map((LocalbodyElement item) {
                  return DropdownMenuItem<LocalbodyElement>(
                    value: item,
                    child: Text(item.localbodyName ?? '',
                        style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                style: const TextStyle(color: Colors.black),

                // Text color of the selected item
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 26, top: 3),
            child: Text(
              'Select Your Localbody Type',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),
          ListTile(
            title: const Text(
              'Panchayath',
              style: TextStyle(color: Colors.white),
            ),
            leading: Radio(
              fillColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.red;
                  }
                  return Colors.white;
                },
              ),
              value: '6586cf433c4aaf21bd1452a0',
              groupValue: localbody,
              onChanged: (String? value) {
                setState(() {
                  localbody = value.toString();
                });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Municipality',
              style: TextStyle(color: Colors.white),
            ),
            leading: Radio(
              fillColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.red;
                  }
                  return Colors.white;
                },
              ),
              value: '6587bb366a0cc71ecfab89b0',
              groupValue: localbody,
              onChanged: (String? value) {
                setState(() {
                  localbody = value.toString();
                });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Corporation',
              style: TextStyle(color: Colors.white),
            ),
            leading: Radio(
              fillColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.red;
                  }
                  return Colors.white;
                },
              ),
              value: '6587bb7a6a0cc71ecfab89b2',
              groupValue: localbody,
              onChanged: (String? value) {
                setState(() {
                  localbody = value.toString();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 26, top: 10),
            child: TextField(
                controller: psController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () async {
                  String firstName = fnController.text;
                  String lastName = lnController.text;
                  String password = psController.text;
                  String email = emController.text;
                  String address = adController.text;
                  String pincode = pinController.text;
                  String district = dsController.text;
                  String localbodyName = lbcontroller.text;
                  String? fklocalbodyTypeId = localbody;
                  String? fkRoleId = "6581eabb9e3ba253cc4946cc".toString();
                  LocalbodyElement? fklocalbodyId = selectedValue;
                  String phone = phController.text;

                  Signup data = await submitData(
                      firstName,
                      lastName,
                      password,
                      email,
                      address,
                      pincode,
                      district,
                      localbodyName,
                      fkRoleId,
                      fklocalbodyId,
                      fklocalbodyTypeId,
                      phone);

                  setState(() {
                    _signup = data;
                  });
                  print(localbody);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Registered Successfully"),
                    behavior: SnackBarBehavior.floating,
                  ));
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return const Loginpage();
                    }),
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
