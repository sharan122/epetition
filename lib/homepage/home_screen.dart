// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mass_petition_app/Models/ShowPosrMode.dart';
import 'package:mass_petition_app/Models/VoteModel.dart';
import 'package:mass_petition_app/Loginpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List? fkPostId;

class _HomeScreenState extends State<HomeScreen> {
  get apiUrl => "http://54.89.172.156";
  String? fkPostId;
  String? votecount;
  Future<Postcard> fetchPosts() async {
    try {
      const String apiUrl = 'http://54.89.172.156/localbodyPost';
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'fklocalbodyId': LocalBodyId}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['post'];
        print(jsonData);
        for (int index = 0; index < jsonData.length; index++) {
          votecount = jsonData.isNotEmpty
              ? jsonData[index]["voteCount"].toString()
              : null;
          print('vote count: $votecount');
          fkPostId =
              jsonData.isNotEmpty ? jsonData[index]["_id"].toString() : null;
          print("fkPostId: $fkPostId");
        }
        return Postcard.fromJson(
          {'post': jsonData},
        );
      } else {
        throw Exception(
            'Failed to load posts. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Exception during API call: $error');
      rethrow;
    }
  }

  Future<void> _refresh() async {
    setState(() {
      fetchPosts();
    });
  }

  Future<Vote> votes(String postId) async {
    try {
      const String apiUrl = 'http://54.89.172.156/caseVote';

      print('login id :$userLoginId');
      print('postId: $fkPostId');
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'fkUserLoginId': userLoginId, "fkPostId": fkPostId}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        return Vote.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load posts. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Exception during API call: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<Postcard>(
          future: fetchPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Post> posts = snapshot.data!.post;
              return ListView.builder(
                reverse: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Card(
                      elevation: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "Anonymous",
                              style: GoogleFonts.timmana(
                                color: const Color.fromARGB(255, 6, 6, 6),
                                fontSize: 25,
                              ),
                            ),
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage("images/avatar.png"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${posts[index].title}',
                              style: GoogleFonts.palanquin(
                                  color: const Color.fromARGB(255, 7, 7, 7),
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${posts[index].description}',
                              style: GoogleFonts.allerta(
                                color: const Color.fromARGB(255, 7, 7, 7),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${posts[index].location}',
                              style: GoogleFonts.abel(
                                  color: const Color.fromARGB(255, 7, 7, 7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              apiUrl + posts[index].media,
                            ),
                          ),
                          ListTile(
                            iconColor: Colors.black,
                            leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  fkPostId = posts[index].id;
                                  votecount = posts[index].voteCount.toString();
                                });
                                votes(
                                    fkPostId!); // Pass the postId to the votes function
                              },
                              icon: const Icon(
                                Icons.thumb_up_alt_outlined,
                                size: 30,
                              ),
                            ),
                            trailing: Text(
                              "Users voted: ${posts[index].voteCount}",
                              style: GoogleFonts.palanquin(
                                  color: const Color.fromARGB(255, 7, 7, 7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
