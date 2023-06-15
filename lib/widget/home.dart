// ignore_for_file: dead_code
import 'package:e_commerce/widget/checkout.dart';
import 'package:e_commerce/widget/constant/colors.dart';
import 'package:e_commerce/widget/constant/userImgFromFirestore.dart';
import 'package:e_commerce/widget/products.dart';
import 'package:e_commerce/widget/profile_page.dart';
import 'package:e_commerce/widget/provider/Cart.dart';
import 'package:e_commerce/widget/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant/username.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String facebook_url = "https://www.facebook.com/ashraf.esam.7146";
    String linkedIn = "https://www.linkedin.com/in/ashraf-essam-06ab93227/";
    // ignore: unused_local_variable
    String Twitter = "https://twitter.com/ashrafesam0";
    String Instagram = "https://www.instagram.com/ashrafesam10/";
    String github = "https://github.com/Ashraf50";
    // ignore: unused_local_variable
    final user_details = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Username(),
                    accountEmail: Text(
                      user_details.email!,
                      style: TextStyle(fontSize: 25),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/back.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    currentAccountPicture: ImgUser(),
                  ),
                  ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("MyProducts"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkout(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Profile Page"),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile_page(),
                        ),
                      );
                      
                    },
                  ),
                  ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.question_answer),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ));
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    // margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "developed by @Ashraf Essam",
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: "my_font",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await launch(facebook_url);
                          },
                          child: Image.asset(
                            "assets/img/facebook-app-symbol.png",
                            width: 20,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launch(Instagram);
                          },
                          child: Image.asset(
                            "assets/img/instagram.png",
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launch(Twitter);
                          },
                          child: Image.asset(
                            "assets/img/twitter.png",
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launch(linkedIn);
                          },
                          child: Image.asset(
                            "assets/img/linkedin.png",
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launch(github);
                          },
                          child: Image.asset(
                            "assets/img/github.png",
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppBarColor,
          title: Text(
            "Home",
            style: TextStyle(fontSize: 25),
          ),
          actions: [
            Consumer<Cart>(
              builder: ((context, xxx, child) {
                return Stack(
                  children: [
                    Container(
                      child: Text(
                        "${xxx.selectedProduct.length}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checkout(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add_shopping_cart,
                        size: 20,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Consumer<Cart>(
              builder: ((context, classInstancee, child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 9),
                  child: Row(
                    children: [
                      Text(
                        "\$ ${classInstancee.price}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Products(),
        ),
      ),
    );
  }
}
