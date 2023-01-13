import 'dart:math';

import 'package:ajudapet/models/cart.dart';
import 'package:ajudapet/models/order.dart';
import 'package:flutter/material.dart';

class OrderList with ChangeNotifier{

  List<Order> _items = [];

  List<Order> get items{
    return [..._items];
  }

  int get itemsCount{
    return _items.length;
  }

  void addOrder(Cart cart){
    _items.insert(
      0,
      Order(
        idOrder: Random().nextDouble().toString(),  
        animalAd: cart.items.values.toList(), 
        date: DateTime.now(),
        )
    );
    notifyListeners();
  }
}