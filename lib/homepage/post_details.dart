// ignore_for_file: must_be_immutable, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mass_petition_app/Loginpage.dart';
import 'package:mass_petition_app/Models/CloseCaseModel.dart';
import 'package:mass_petition_app/Models/PostDetailsModel.dart';
import 'package:mass_petition_app/Models/ViewChatModel.dart';
import 'package:mass_petition_app/homepage/chat.dart';
import 'package:mass_petition_app/homepage/homepage.dart';
import 'package:mass_petition_app/homepage/post_list.dart';
import 'package:provider/provider.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({
    super.key,
  });

  @override
  State<PostDetails> createState() => _PostDetailsState();
  static void popFromStack(BuildContext context) {
    Navigator.pop(context);
  }
}

String? chatId;
String? CaseStaus;
String? currestPostId = listPostId;
List<ChatMessage> user1Messages = [];
List<ChatMessage> user2Messages = [];
String? grName;
String? grPh;
String? dep;

Future<void> fetchChat(BuildContext context) async {
  String? chatID = listPostId;
  try {
    final response = await http.post(
      Uri.parse('http://54.89.172.156/viewMessege'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fkPostId': chatID,
        'fkUserLoginId': userLoginId,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('API Response: $data');

      if (data['chat'] != null && data['chat'] is Map) {
        final Map<String, dynamic> chatData = data['chat'];
        chatId = chatData["_id"].toString();
        print('ChatId: $chatId');
        if (chatData['message'] != null && chatData['message'] is List) {
          List<ChatMessage> messages = List.from(
            chatData['message'].map((x) => ChatMessage.fromJson(x)),
          );

          Provider.of<UserMessagesProvider>(context, listen: false)
              .setUser1Messages(messages
                  .where((message) => message.fkUserLoginId == userLoginId)
                  .toList());
          Provider.of<UserMessagesProvider>(context, listen: false)
              .setUser2Messages(messages
                  .where((message) => message.fkUserLoginId != userLoginId)
                  .toList());

          print('User 1 Messages: $user1Messages');
          print('User 2 Messages: $user2Messages');
        } else {
          throw Exception('Invalid chat data format');
        }
      } else {
        throw Exception('Invalid chat data format');
      }
    } else {
      throw Exception(
          'Failed to load chat. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}

class _PostDetailsState extends State<PostDetails> {
  get apiUrl => "http://54.89.172.156";

  @override
  void initState() {
    super.initState();
    setState(() {
      currestPostId;
    });
  }

  Future<Postdetails> fetchPosts() async {
    try {
      const String apiUrl = 'http://54.89.172.156/viewPost';
      String? pid = listPostId;

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'fkPostId': pid}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData =
            json.decode(response.body)['post'];
        print(jsonData);

        CaseStaus =
            jsonData.isNotEmpty ? jsonData["casestatus"].toString() : null;
        grName = jsonData.isNotEmpty ? jsonData["grname"].toString() : null;
        grPh = jsonData.isNotEmpty ? jsonData["grphone"].toString() : null;
        dep = jsonData.isNotEmpty ? jsonData["dept"].toString() : null;

        return Postdetails.fromJson({'post': jsonData});
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

  Future<CloseCase> close() async {
    const String apiUrl = 'http://54.89.172.156/closeCase';
    String? closePostid = listPostId;

    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'fkPostId': closePostid}));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      // Assuming CloseCase.fromJson method accepts Map<String, dynamic>
      return CloseCase.fromJson(responseData);
    } else {
      // Handle other status codes if needed
      throw Exception('Failed to close case: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: FutureBuilder<Postdetails>(
            future: fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                Post post = snapshot.data!.post;
                return ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Card(
                      elevation: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              post.title.toString(),
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              "Case Status:  $CaseStaus",
                              style: GoogleFonts.anekDevanagari(
                                color: const Color.fromARGB(255, 7, 7, 7),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              apiUrl + post.media,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              post.location.toString(),
                              style: GoogleFonts.tomorrow(
                                color: const Color.fromARGB(255, 7, 7, 7),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          post.description.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                          elevation: 7,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Text(
                                "Department: $dep",
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                '$grName attended this case',
                                style: GoogleFonts.brygada1918(
                                  color: const Color.fromARGB(255, 7, 7, 7),
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Contact: $grPh',
                                style: GoogleFonts.brygada1918(
                                  color: const Color.fromARGB(255, 7, 7, 7),
                                  fontSize: 20,
                                ),
                              ),
                            ]),
                          ))

                      // Padding(
                      //   padding: EdgeInsets.all(9.0),
                      //   child: Card(
                      //     elevation: 10,
                      //     child: ListTile(
                      //       title: Text(
                      //         "Phase 1:",
                      //         style: TextStyle(
                      //             fontSize: 23, fontWeight: FontWeight.bold),
                      //       ),
                      //       subtitle: Text("Status of phase 1"),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(9.0),
                      //   child: Card(
                      //     elevation: 10,
                      //     child: ListTile(
                      //       title: Text(
                      //         "Phase 2:",
                      //         style: TextStyle(
                      //             fontSize: 23, fontWeight: FontWeight.bold),
                      //       ),
                      //       subtitle: Text("Status of phase 2"),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(9.0),
                      //   child: Card(
                      //     elevation: 10,
                      //     child: ListTile(
                      //       title: Text(
                      //         "Phase 3:",
                      //         style: TextStyle(
                      //             fontSize: 23, fontWeight: FontWeight.bold),
                      //       ),
                      //       subtitle: Text("Status of phase 3"),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(9.0),
                      //   child: Card(
                      //     elevation: 10,
                      //     child: ListTile(
                      //       title: Text(
                      //         "Phase 4:",
                      //         style: TextStyle(
                      //             fontSize: 23, fontWeight: FontWeight.bold),
                      //       ),
                      //       subtitle: Text("Status of phase 4"),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            fetchChat(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Chat With GR",
                            style: TextStyle(color: Colors.white),
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            close();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("CASE CLOSEDr!"),
                              behavior: SnackBarBehavior.floating,
                            ));
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) {
                                return const Homepage();
                              }),
                            );
                          },
                          child: const Text(
                            "Close Case",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ]);
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ));
  }
}

class UserMessagesProvider extends ChangeNotifier {
  List<ChatMessage> user1Messages = [];
  List<ChatMessage> user2Messages = [];

  void setUser1Messages(List<ChatMessage> messages) {
    user1Messages = messages;
    notifyListeners();
  }

  void setUser2Messages(List<ChatMessage> messages) {
    user2Messages = messages;
    notifyListeners();
  }

  // You can add more methods to modify your data as needed
}
