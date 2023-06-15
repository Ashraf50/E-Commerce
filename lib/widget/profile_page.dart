// ignore_for_file: unused_local_variable
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widget/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' show basename;
import 'constant/data_from_firestore.dart';
import 'constant/userImgFromFirestore.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final user_details = FirebaseAuth.instance.currentUser!;
  File? imgPath;
  String? imgName;
  uploadImage(ImageSource cameraOrGallary) async {
    final pickedImg = await ImagePicker().pickImage(source: cameraOrGallary);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: Text(
          "Profile Page",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 153, 147, 147),
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? ImgUser()
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                height: 145,
                                width: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        bottom: -5,
                        right: -12,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await uploadImage(
                                                ImageSource.gallery);
                                            if (imgPath != null) {
                                              final storageRef = FirebaseStorage.instance.ref(imgName); 
                                              await storageRef.putFile(imgPath!);
                                              String url = await storageRef.getDownloadURL(); 
                                              users
                                                  .doc(user_details.uid)
                                                  .update({"imgLink": url,},);
                                              
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text(
                                                "Choose Photo",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await uploadImage(
                                                ImageSource.camera);
                                            if (imgPath != null) {
                                              final storageRef = FirebaseStorage
                                                  .instance
                                                  .ref(imgName);
                                              await storageRef
                                                  .putFile(imgPath!);
                                              String url = await storageRef
                                                  .getDownloadURL();
                                              users
                                                  .doc(user_details.uid)
                                                  .update(
                                                {
                                                  "imgLink": url,
                                                },
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text(
                                                "Take Photo",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Color.fromARGB(255, 139, 139, 140),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GetUserData(documentId: user_details.uid),
              SizedBox(
                height: 15,
              ),
              Text(
                "Created date: ${DateFormat('d MMMM y').format(user_details.metadata.creationTime!)}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Last Sign date:${DateFormat('d MMMM y').format(user_details.metadata.lastSignInTime!)}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
