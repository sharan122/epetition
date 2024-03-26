// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mass_petition_app/Loginpage.dart';
import 'package:mass_petition_app/Models/PostListModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mass_petition_app/homepage/post_details.dart';
// import 'package:mass_petition_app/Loginpage.dart';

class ListPost extends StatefulWidget {
  const ListPost({super.key});

  @override
  State<ListPost> createState() => _ListPostState();
}

String? listPostId;

class _ListPostState extends State<ListPost> {
  late Future<PostList> futurePosts;

  // String fkUserLoginId = SharedPreferencesHelper.getUserId().toString();

  @override
  void initState() {
    super.initState();
    futurePosts = showlist();
  }

  Future<PostList> showlist() async {
    const String apiUrl = 'http://54.89.172.156/veiw_createdPost';

    // try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({'fkUserLoginId': userLoginId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['post'];
      print(responseData);
      for (int index = 0; index < responseData.length; index++) {
        listPostId = responseData.isNotEmpty
            ? responseData[index]["_id"].toString()
            : null;
      }
      return PostList.fromJson({'post': responseData});
    } else {
      print('API Error: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
    //   } catch (e) {
    //     print('Exception during API call: $e');
    //     throw Exception('Failed to load data');
    //   }
  }

  Future<void> _refresh() async {
    setState(() {
      futurePosts = showlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Post"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<PostList>(
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
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, right: 5),
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
                          onTap: () {
                            setState(() {
                              listPostId = posts[index].id;
                              print('Updated listPostId: $listPostId');
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) {
                                return const PostDetails();
                              }),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
