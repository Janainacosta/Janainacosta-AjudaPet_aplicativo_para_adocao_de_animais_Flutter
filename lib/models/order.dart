import 'package:ajudapet/models/cart_item.dart';

class Order{
  final String idOrder;
  final List<CartItem> animalAd;
  final DateTime date;

  Order({
    required this.idOrder,
    required this.animalAd,
    required this.date,
  });
}