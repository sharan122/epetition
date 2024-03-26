import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          child: ListTile(
            title: const Text("Username"),
            subtitle: const Text("username will be shown here"),
            trailing:
                ElevatedButton(onPressed: () {}, child: const Text("Edit")),
          ),
        ),
        // const Divider(
        //   thickness: 1.5,
        // ),
        Card(
          elevation: 3,
          child: ListTile(
            title: const Text("Phone Number"),
            subtitle: const Text("Phone number will be shown here"),
            trailing:
                ElevatedButton(onPressed: () {}, child: const Text("Edit")),
          ),
        ),
        // const Divider(thickness: 1.5),
        Card(
          elevation: 3,
          child: ListTile(
            title: const Text("Email"),
            subtitle: const Text("Email will be shown here"),
            trailing:
                ElevatedButton(onPressed: () {}, child: const Text("Edit")),
          ),
        ),
        // const Divider(thickness: 1.5),
        Card(
          elevation: 3,
          child: ListTile(
            title: const Text("Address"),
            subtitle: const Text("Address number will be shown here"),
            trailing:
                ElevatedButton(onPressed: () {}, child: const Text("Edit")),
          ),
        ),
        // const Divider(thickness: 1.5),
        Card(
          elevation: 3,
          child: ListTile(
            title: const Text("Pincode"),
            subtitle: const Text("Pincode number will be shown here"),
            trailing:
                ElevatedButton(onPressed: () {}, child: const Text("Edit")),
          ),
        ),
        // const Divider(thickness: 1.5),
      ],
    );
  }
}
