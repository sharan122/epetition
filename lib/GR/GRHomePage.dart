// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mass_petition_app/Models/GRHomePageModel.dart';
import 'package:http/http.dart' as http;

class GRHome extends StatefulWidget {
  const GRHome({super.key});

  @override
  State<GRHome> createState() => _GRHomeState();
}

class _GRHomeState extends State<GRHome> {
  Future<Grhome> showlist() async {
    const String apiUrl = 'http://54.89.172.156/grPost';
    String? fkgrepLoginId = "65d4ce717427bd0f56cd2b96";
    // try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({'fkgrepLoginId': fkgrepLoginId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['post'];
      print(responseData);
      return Grhome.fromJson({'post': responseData});
    } else {
      print('API Error: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
    //   } catch (e) {
    //     print('Exception during API call: $e');
    //     throw Exception('Failed to load data');
    //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GR HOME PAGE"),
      ),
      body: FutureBuilder<Grhome>(
          future: showlist(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<Post> posts = snapshot.data!.post;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: Card(
                      elevation: 10,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${posts[index].title}',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${posts[index].description}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
