import 'package:flutter/material.dart';

class Forgotp extends StatelessWidget {
  const Forgotp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 90),
            child: Center(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 50, left: 50, right: 50),
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 50, right: 50),
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'OTP',
                  hintStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          )
        ],
      )),
    );
  }
}
