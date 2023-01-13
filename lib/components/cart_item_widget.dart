import 'package:ajudapet/models/cart.dart';
import 'package:ajudapet/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({required this.cartItem ,super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      //key: ValueKey(cartItem.idAnimalAd),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      confirmDismiss: (_){
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Tem certeza?'),
            content: Text('Quer remover o animal?'),
            actions: [
              TextButton(
                child: Text('Não'),
                onPressed: (){
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: (){
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (_){
        Provider.of<Cart>(
          context, listen: false
          ).removeItem(cartItem.animalAdId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('kkk'),
              ), 
              ),
            ),
            title: Text(cartItem.nome),
            subtitle: Text('ooo'),
            trailing: Text('iiii'),
          ),
        ),
      ),
    );
  }
} 