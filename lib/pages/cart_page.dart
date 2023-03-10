import 'package:ajudapet/components/cart_item_widget.dart';
import 'package:ajudapet/models/cart.dart';
import 'package:ajudapet/models/cart_item.dart';
import 'package:ajudapet/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList( );

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pets:',
                    style: TextStyle(
                    fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      '${cart.itemsCount}',
                      style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    child: Text('ADOTAR'),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      )
                    ),
                    onPressed: () {
                      Provider.of<OrderList>(context,
                      listen: false,
                      ).addOrder(cart);

                      cart.clear();
                    }, 
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => CartItemWidget(cartItem: items[i]),
            ),
          ),
        ],
      ),
    );
  }
}