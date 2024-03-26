import 'package:flutter/material.dart';
import 'package:mass_petition_app/GR/GRlogin.dart';
import 'package:mass_petition_app/Loginpage.dart';

class Role extends StatelessWidget {
  const Role({super.key});

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
                'Choose Your Role',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) {
                    return const Loginpage();
                  }),
                );
              },
              child: const Text('USER')),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) {
                    return const GRLoginpage();
                  }),
                );
              },
              child: const Text('GR')),
        ],
      )),
    );
  }
}
