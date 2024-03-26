// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class Mapview extends StatefulWidget {
  const Mapview({super.key});

  @override
  State<Mapview> createState() => _MapState();
}

double? lat;
double? long;
String? loc;

class _MapState extends State<Mapview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: OpenStreetMapSearchAndPick(
          center: const LatLong(23, 89),
          buttonColor: Colors.blue,
          buttonText: 'Set Current Location',
          onPicked: (pickedData) {
            lat = pickedData.latLong.latitude;
            long = pickedData.latLong.longitude;
            loc = pickedData.addressName;
            print("latitiude : $lat ");
            print("londitude : $long ");
            print("location : $loc ");
            Navigator.of(context).pop();
            _showSnackbar(context); // Display snackbar
          },
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Location Selected'), // Modify the message as needed
      ),
    );
  }
}
