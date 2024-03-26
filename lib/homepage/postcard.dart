import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mass_petition_app/Models/ShowPosrMode.dart';

class Postcard extends StatefulWidget {
  const Postcard({super.key});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  Future<List<Post>> fetchPosts() async {
    const String apiUrl = 'http://54.89.172.156/localbodyPost';
    String fklocalbodyId = "65c3bc5e9a3512258a17c40c";
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({'fklocalbodyId': fklocalbodyId}),
      headers: {'Content-Type': 'application/json'},
      // You can customize headers and send parameters in the request body if needed
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['post'];
      return jsonData.map((data) => Post.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Post>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Card(
                // Customize the card UI as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title: ${posts[index].title}',
                      style: GoogleFonts.ubuntuMono(
                          color: const Color.fromARGB(255, 7, 7, 7),
                          fontSize: 30),
                    ),
                    Text('Description: ${posts[index].description},',
                        style: GoogleFonts.ubuntuMono(
                            color: const Color.fromARGB(255, 7, 7, 7),
                            fontSize: 30)),
                    Text('Location: ${posts[index].location}'),
                    Image.network(posts[index].media),
                  ],
                ),
              );
            },
          );
        }
      },
    ));
  }
}
