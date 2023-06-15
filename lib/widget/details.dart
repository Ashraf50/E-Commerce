import 'package:e_commerce/widget/checkout.dart';
import 'package:e_commerce/widget/products.dart';
import 'package:e_commerce/widget/provider/Cart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constant/colors.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  element product;
  Details({
    required this.product,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool showMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: Text(
          "Details",
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
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(widget.product.imgPath),
          SizedBox(
            height: 20,
          ),
          Text(
            "\$${widget.product.salary.toString()}",
            style: TextStyle(fontSize: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 228, 79, 158),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("New")),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.location_on,
                  color: Colors.grey[700],
                ),
                label: Text(
                  widget.product.location.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(
              width: double.infinity,
              child: Text(
                "Details:",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 13,
          ),
          Text(
            "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers produce gametophytes, which in flowering plants consist of a few haploid cells which produce gametes. The  gametophyte, which produces non-motile sperm, is enclosed within pollen grains; the gametophyte is contained within the ovule. When pollen from the anther of a flower is deposited on the stigma, this is called pollination. Some flowers may self-pollinate, producing seed using pollen from the same flower or a different flower of the same plant, but others have mechanisms to prevent self-pollination and rely on cross-pollination, when pollen is transferred from the anther of one flower to the stigma of another flower on a different individual of the same species",
            style: TextStyle(fontSize: 23, overflow: TextOverflow.fade),
            maxLines: showMore ? 3 : null,
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (showMore == true) {
                  showMore = false;
                } else {
                  showMore = true;
                }
              });
            },
            child: Text(
              showMore ? "Show more" : "show less",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ]),
      ),
    );
  }
}
