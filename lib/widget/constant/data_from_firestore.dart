import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widget/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'MyTextfield.dart';

class GetUserData extends StatefulWidget {
  final String documentId;

  GetUserData({
    required this.documentId,
  });

  @override
  State<GetUserData> createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  final user_controller = TextEditingController();
  final email_controller = TextEditingController();
  final pass_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final user_details = FirebaseAuth.instance.currentUser;

    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Username: ${data['username']}",
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyTextfield(
                                      control: user_controller,
                                      hintText: "Enter new username",
                                      keyboardType: TextInputType.text,
                                      obscureText: false,
                                      suffixIcon: Icon(Icons.person),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            users.doc(user_details!.uid).update(
                                              {
                                                "username":
                                                    user_controller.text,
                                              },
                                            );
                                          },
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                textfield_color),
                                        shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email: ${data['email']}",
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyTextfield(
                                      control: email_controller,
                                      hintText: "Enter new email",
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: false,
                                      suffixIcon: Icon(Icons.email),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            users.doc(user_details!.uid).update(
                                              {
                                                "email": email_controller.text,
                                              },
                                            );
                                          },
                                        );

                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                textfield_color),
                                        shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Password: ${data['password']}",
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyTextfield(
                                      control: TextEditingController(),
                                      hintText: "Enter new password",
                                      keyboardType: TextInputType.text,
                                      obscureText: false,
                                      suffixIcon: Icon(Icons.password),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            users.doc(user_details!.uid).update(
                                              {
                                                "password":
                                                    pass_controller.text,
                                              },
                                            );
                                          },
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                textfield_color),
                                        shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ],
          );
        }
        return Text("loading");
      },
    );
  }
}
