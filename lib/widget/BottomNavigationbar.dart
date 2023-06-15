import 'package:e_commerce/widget/checkout.dart';
import 'package:e_commerce/widget/home.dart';
import 'package:e_commerce/widget/profile_page.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  change_item(int value) {
    print(value);
    setState(() {
      currentIndex = value;
    });
  }

  List pages = [
    Home(),
    Checkout(),
    Profile_page(),
  ]; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "My Products",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profile",
          ),
        ],
        elevation: 20,
        currentIndex: currentIndex,
        onTap: change_item,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
