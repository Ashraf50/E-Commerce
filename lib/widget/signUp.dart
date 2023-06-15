import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widget/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'constant/MyTextfield.dart';
import 'constant/colors.dart';
import 'constant/snackBar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:path/path.dart' show basename;

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final email_controller = TextEditingController();
  final user_controller = TextEditingController();
  final password_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool ISpassword_on_off = true;
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

  // function of signUp in firebase
  register() async {
    showDialog(
        context: context,
        builder: (context) {
          return SpinKitFadingCircle(
            color: Color.fromARGB(146, 12, 16, 49),
            size: 160.0,
          );
        });
    try {
      // register
      // ignore: unused_local_variable

      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email_controller.text,
        password: password_controller.text,
      );

// Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref(imgName);
      await storageRef.putFile(imgPath!);
      String Image_Link = await storageRef.getDownloadURL();
      // send data to database
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');

      users
          .doc(user.user!.uid)
          .set({
            'imgLink': Image_Link,
            'username': user_controller.text,
            'email': email_controller.text,
            'password': password_controller.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists");
      } else {
        showSnackBar(context, "Error");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    password_controller.dispose();
    email_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: Text("Sign Up"),
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 153, 147, 147),
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Color.fromARGB(255, 194, 189, 189),
                              backgroundImage: AssetImage(
                                "assets/img/avatar.png",
                              ),
                            )
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
                MyTextfield(
                  control: user_controller,
                  keyboardType: TextInputType.text,
                  hintText: "Enter Your Username",
                  obscureText: false,
                  suffixIcon: Icon(
                    Icons.person,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? "Enter a valid email"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: email_controller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Enter Your Email",
                      suffixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      return value!.length < 6
                          ? "Enter at least 6 character"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: password_controller,
                    obscureText: ISpassword_on_off,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Enter Your Password",
                      suffixIcon: IconButton(
                        icon: ISpassword_on_off
                            ? (Icon(
                                Icons.visibility,
                              ))
                            : (Icon(
                                Icons.visibility_off,
                              )),
                        onPressed: () {
                          setState(() {
                            if (ISpassword_on_off == true) {
                              ISpassword_on_off = false;
                            } else {
                              ISpassword_on_off = true;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        imgName != null &&
                        imgPath != null) {
                      await register();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    } else {
                      showSnackBar(context, "check the email or password");
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                    backgroundColor: MaterialStatePropertyAll(textfield_color),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 17),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
