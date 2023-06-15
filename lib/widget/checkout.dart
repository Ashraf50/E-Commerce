import 'package:e_commerce/widget/provider/Cart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constant/colors.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    final Instance_of_cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: Text(
          "Checkout",
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
                    onPressed: () {},
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
        padding: const EdgeInsets.all(4),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 550,
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: Instance_of_cart.selectedProduct.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            "${Instance_of_cart.selectedProduct[index].name}"),
                        subtitle: Text(
                            "${Instance_of_cart.selectedProduct[index].salary} : ${Instance_of_cart.selectedProduct[index].location}"),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              "${Instance_of_cart.selectedProduct[index].imgPath}"),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            Instance_of_cart.delete(
                                Instance_of_cart.selectedProduct[index]);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Pay  ${Instance_of_cart.price}\$",
                  style: TextStyle(fontSize: 22),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green[400]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
