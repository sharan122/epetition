import 'package:flutter/material.dart';
import 'package:mass_petition_app/editAccount/customcard.dart';

class EditAc extends StatelessWidget {
  const EditAc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 100, top: 30),
              child: Text("Edit Account",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 35,
            ),
            CustomCard(),
          ],
        ),
      ),
    );
  }
}
