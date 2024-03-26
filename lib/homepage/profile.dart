import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_petition_app/editAccount/editac.dart';
import 'package:mass_petition_app/homepage/post_list.dart';
// import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Title(
              color: Colors.black,
              child: Text(
                'My Profile',
                textAlign: TextAlign.center,
                style: GoogleFonts.allerta(
                    color: Color.fromARGB(255, 7, 7, 7),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            maxRadius: 70,
            backgroundColor: Colors.black,
            child: ClipOval(
              child: Image.asset(
                'images/user.jpg',
                width: 135,
                height: 135,
              ),
            ),
            //foregroundColor: Colors.black,
            // backgroundImage: AssetImage(
            //'images/jishnu.jpg',
            //  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) {
                    return const EditAc();
                  }),
                );
              },
              // ignore: prefer_const_constructors, sort_child_properties_last
              child: const Text(
                "Edit Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.black26))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) {
                    return const ListPost();
                  }),
                );
              },
              // ignore: prefer_const_constructors, sort_child_properties_last
              child: const Text(
                "My Post",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.black26))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
            child: ElevatedButton(
              onPressed: () {},
              // ignore: prefer_const_constructors, sort_child_properties_last
              child: const Text(
                "Setting",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.black26))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
            child: ElevatedButton(
              onPressed: () {},
              // ignore: prefer_const_constructors, sort_child_properties_last
              child: const Text(
                "About",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.black26))),
            ),
          )
        ],
      )),
    );
  }
}
