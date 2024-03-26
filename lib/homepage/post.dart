// ignore_for_file: empty_statements, avoid_print, unused_field, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:bson/bson.dart';
// import 'package:mass_petition_app/Loginpage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mass_petition_app/Loginpage.dart';
import 'package:mass_petition_app/Models/MediaModel.dart';
import 'package:http/http.dart' as http;
import 'package:mass_petition_app/Models/PostModel.dart';
import 'package:mass_petition_app/homepage/homepage.dart';
import 'package:mass_petition_app/homepage/map.dart';

import '../Models/LocalBodyModel.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool _uploading = false;
  double _uploadProgress = 0.0;
  PlatformFile? pickedfile;
  Media? file_path;
  // String? _fileName;
  FilePickerResult? result;
  bool isLoading = false;
  File? filePath;
  final _title = TextEditingController();
  final _description = TextEditingController();
  // final _pincode = TextEditingController();
  final _location = TextEditingController();
  Postmodel? _upload;
  String? paths;
  List<LocalbodyElement>? localbodies;
  LocalbodyElement? selectedValue;
  @override
  void initState() {
    super.initState();
    fetchLocalbodies().then((data) {
      setState(() {
        localbodies = data.localbody;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          _uploading
              ? LinearProgressIndicator(
                  value: _uploadProgress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : Container(),
          const SizedBox(
            height: 65,
          ),
          IconButton(
            onPressed: () async {
              File? pickfileResult = await pickFile();
              if (pickfileResult != null) {
                uploadFile();
              } else {
                print('error: No file picked');
              }
            },
            icon: const Icon(
              Icons.add,
            ),
            iconSize: 65,
          ),
          const Center(
              child: Text(
            "Add Media",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: TextField(
              controller: _title,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: 'Add Title',
                  hintStyle: TextStyle(color: Colors.grey)),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _description,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                  hintText: 'Add Description',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.black),
              )),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black, width: 1)),
              child: DropdownButton<LocalbodyElement>(
                dropdownColor: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                isExpanded: true,
                value: selectedValue,
                hint: const Text('Select a localbody',
                    style: TextStyle(color: Colors.grey)),
                onChanged: (LocalbodyElement? newValue) {
                  setState(() {
                    selectedValue = newValue;
                    // Add your logic here when an item is selected
                    if (selectedValue != null) {
                      print(
                          'Selected Localbody: ${selectedValue!.localbodyName}');
                      // Add your database storage logic here
                    }
                  });
                },
                items: localbodies?.map((LocalbodyElement item) {
                  return DropdownMenuItem<LocalbodyElement>(
                    value: item,
                    child: Text(item.localbodyName ?? '',
                        style: const TextStyle(color: Colors.grey)),
                  );
                }).toList(),
                style: const TextStyle(color: Colors.black),
                // Text color of the selected item
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 252, 249, 249),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return const Mapview();
                    }),
                  );
                },
                child: const Text('Open Map To Select Case Location')),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 26, top: 3),
            child: Text(
              'Select Your Localbody Type',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 130),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
              ),
              onPressed: () async {
                // String? fkUserLoginId =
                //     await SharedPreferencesHelper.getUserId();
                String fkUserLoginId = "65d1ff0f6f658590780109ef";
                String title = _title.text;
                String description = _description.text;
                String? location = loc;
                String media = paths.toString();
                String fkRoleId =
                    ObjectId.fromHexString("6581eabb9e3ba253cc4946cc")
                        .toHexString();
                double? mlat = lat;
                double? mlong = long;
                print('fkRoleId: $fkRoleId');
                LocalbodyElement? fklocalbodyId = selectedValue;
                Postmodel data = await mediaUpload(title, description, location,
                    media, fkUserLoginId, fkRoleId, fklocalbodyId, mlat, mlong);

                setState(() {
                  _upload = data;
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("POSTED!"),
                  behavior: SnackBarBehavior.floating,
                ));
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) {
                    return const Homepage();
                  }),
                );
              },
              child: const Text(
                'POST',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          )
        ],
      )),
    );
  }

  Future<File?> pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: true);
      if (result != null && result!.files.isNotEmpty) {
        pickedfile = result!.files.first;
        if (pickedfile!.size <= 2 * 1024 * 1024) {
          filePath = File(pickedfile!.path.toString());
          print('filepath: $pickedfile');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Image Uploaded Successfully"),
            behavior: SnackBarBehavior.floating,
          ));
          setState(() {
            isLoading = false;
          });
          return filePath;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("File size exceeds 1MB limit"),
            behavior: SnackBarBehavior.floating,
          ));
          // Show error message or handle oversized file
          print("File size exceeds 1MB limit");
        }
        setState(() {
          isLoading = false;
        });
        return filePath;
      } else {
        print("No file selected");
        // return null;
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error picking files: $e");
      // return null;
    }
    return null;
  }

  Future<Media> uploadFile() async {
    String apiUrl = "http://54.89.172.156/postUpload";
    setState(() {
      _uploading = true;
      _uploadProgress = 0.0; // Set uploading to true when starting the upload
    });
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.files.add(http.MultipartFile('myfile',
          File(filePath!.path).readAsBytes().asStream(), pickedfile!.size,
          filename: pickedfile!.name));

      final respones = await request.send();

      if (respones.statusCode == 200) {
        Map<String, dynamic> jsonResponse =
            json.decode(await respones.stream.bytesToString());
        print('Response: $jsonResponse');
        paths = jsonResponse['file_path'].toString();
        setState(() {
          _uploading = false;
          _uploadProgress =
              0.0; // Set uploading to false when upload is completed
        });
        return Media.fromJson({'myfile': filePath?.path});
      } else {
        print('Error uploading:${respones.statusCode}');
        setState(() {
          _uploading = false;
          _uploadProgress = 0.0; // Set uploading to false if there's an error
        });
        throw Exception("error while uploading");
      }
    } catch (e) {
      print('Error:$e');
      setState(() {
        _uploading = false;
        _uploadProgress = 0.0; // Set uploading to false if there's an exception
      });
      throw Exception("Error while uploading");
    }
  }

  Future<Postmodel> mediaUpload(title, description, location, media,
      fkUserLoginId, fkRoleId, fklocalbodyId, mlat, mlong) async {
    const String apiUrl1 = "http://54.89.172.156/create_post";
    try {
      // String? fkUserLoginId = await SharedPreferencesHelper.getUserId();
      String? fkUserLoginId = userLoginId;
      final response = await http.post(Uri.parse(apiUrl1),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "title": title,
            "description": description,
            "location": location,
            "media": paths,
            "fkUserLoginId": fkUserLoginId,
            "fkRoleId": fkRoleId,
            "fklocalbodyId": fklocalbodyId.id.toString(),
            "maplat": mlat,
            "maplong": mlong,
          }));
      var data = response.body;
      print(data);
      if (response.statusCode == 200) {
        return Postmodel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        print("error: ${response.statusCode}");
        throw Exception("failed to create post");
      }
    } catch (e) {
      print("exception: $e");
      throw Exception("Failed to create post");
    }
  }

  Future<Localbody> fetchLocalbodies() async {
    final response = await http.get(Uri.parse(
        'http://54.89.172.156/list_localbody')); // Replace with your actual API endpoint

    if (response.statusCode == 200) {
      return Localbody.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load localbodies');
    }
  }
}
