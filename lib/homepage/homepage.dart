import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_petition_app/Loginpage.dart';
import 'package:mass_petition_app/homepage/home_screen.dart';
//import 'package:mass_petition_app/homepage/home_screen.dart';
// import 'package:mass_petition_app/homepage/notifications.dart';
import 'package:mass_petition_app/homepage/post.dart';
import 'package:mass_petition_app/homepage/profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _index = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const Post(),
    // const Notifications(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' E-PETITION',
          style: GoogleFonts.archivoBlack(
              color: const Color.fromARGB(255, 7, 7, 7),
              fontSize: 27,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 5),
            child: Text(
              '$Name',
              style: GoogleFonts.palanquin(
                  color: const Color.fromARGB(255, 7, 7, 7),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      extendBody: true,
      backgroundColor: Colors.black,
      body: _screens[_index],
      bottomNavigationBar: FloatingNavbar(
          iconSize: 33.0,
          fontSize: 13.0,
          items: [
            FloatingNavbarItem(
              icon: Icons.home_filled,
              title: "Home",
            ),
            FloatingNavbarItem(
              icon: Icons.add_circle_outline_sharp,
              title: "Post",
            ),
            // FloatingNavbarItem(
            //     icon: Icons.notification_add_sharp, title: "Notifications"),
            FloatingNavbarItem(icon: Icons.account_circle, title: "Profile"),
          ],
          currentIndex: _index,
          onTap: (i) {
            setState(() {
              _index = i;
            });
          }),
    );
  }
}
