import 'package:flutter/material.dart';
import 'package:mass_petition_app/registration/forgotpassword/fp.dart';

class Forgotps extends StatelessWidget {
  const Forgotps({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 100, right: 0, top: 23, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              // Add your button's onPressed logic here
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) {
                  return const Forgotp();
                }),
              );
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold // Text color
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
