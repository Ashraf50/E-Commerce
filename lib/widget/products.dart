import 'package:e_commerce/widget/provider/Cart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class element {
  String imgPath;
  double salary;
  String location;
  String name;
  element({
    required this.imgPath,
    required this.salary,
    required this.location,
    required this.name,
  });
}

List All_product = [
  element(
    name: "Lenovo",
    imgPath: "assets/img/lap1.jpg",
    salary: 200,
    location: "Main Store",
  ),
  element(
    name: "HP Pavilion",
    imgPath: "assets/img/lap2.jpg",
    salary: 150,
    location: "Main Store",
  ),
  element(
    name: "dell",
    imgPath: "assets/img/lap3.jpg",
    salary: 300,
    location: "Main Store",
  ),
  element(
    name: "Lenovo idea pad",
    imgPath: "assets/img/lap4.jpg",
    salary: 100,
    location: "Main Store",
  ),
  element(
    name: "Samsung",
    imgPath: "assets/img/lap5.jpg",
    salary: 230,
    location: "Main Store",
  ),
  element(
    name: "Hp gaming",
    imgPath: "assets/img/lap6.jpg",
    salary: 300,
    location: "Main Store",
  ),
  element(
    name: "hp2560w",
    imgPath: "assets/img/lap7.jpg",
    salary: 410,
    location: "Main Store",
  ),
  element(
    name: "dell precision 5520",
    imgPath: "assets/img/lap8.jpg",
    salary: 250,
    location: "Main Store",
  ),
  element(
    name: "dell precision 5520",
    imgPath: "assets/img/1.webp",
    salary: 250,
    location: "Main Store",
  ),
  element(
    name: "dell precision 5520",
    imgPath: "assets/img/2.webp",
    salary: 250,
    location: "Main Store",
  ),
   element(
    name: "dell precision 5520",
    imgPath: "assets/img/3.webp",
    salary: 250,
    location: "Main Store",
  ),
  element(
    name: "dell precision 5520",
    imgPath: "assets/img/4.webp",
    salary: 250,
    location: "Main Store",
  ),
    element(
    name: "dell precision 5520",
    imgPath: "assets/img/5.webp",
    salary: 250,
    location: "Main Store",
  ),
  element(
    name: "dell precision 5520",
    imgPath: "assets/img/6.webp",
    salary: 250,
    location: "Main Store",
  ),
   element(
    name: "dell precision 5520",
    imgPath: "assets/img/7.webp",
    salary: 250,
    location: "Main Store",
  ),
  element(
    name: "dell precision 5520",
    imgPath: "assets/img/8.webp",
    salary: 250,
    location: "Main Store",
  ),
];

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 17,
            mainAxisSpacing: 33),
        itemCount: All_product.length,
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      product: All_product[index],
                    ),
                  ),
                );
              },
              child: Image.asset(
                All_product[index].imgPath,
              ),
            ),
            footer: GridTileBar(
              trailing: Consumer<Cart>(
                builder: ((context, xxx, child) {
                  return IconButton(
                    color: Color.fromARGB(255, 62, 94, 70),
                    onPressed: () {
                      xxx.add(
                        All_product[index],
                      );
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                  );
                }),
              ),
              leading: Text(
                "\$${All_product[index].salary.toString()}",
              ),
              title: Text(
                "",
              ),
            ),
          );
        },
      ),
    );
  }
}
