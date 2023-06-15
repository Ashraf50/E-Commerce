
import 'package:flutter/material.dart';

import '../products.dart';

class Cart with ChangeNotifier {
  // create new properties & methods
  List selectedProduct = [];
  double price = 0;

  add(element product) {
    selectedProduct.add(product);
    price += product.salary.round();
    notifyListeners();
  }

  delete(element product) {
    selectedProduct.remove(product);
    price -= product.salary.round();
    notifyListeners();
  }
}
