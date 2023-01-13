import 'package:ajudapet/models/animalAd_list.dart';
import 'package:ajudapet/models/animalAd_model.dart';
import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/models/usuario_model.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioItem extends StatelessWidget {
  final Usuario animalAd;
  
  const UsuarioItem(this.animalAd, { super.key});
  
  @override
  Widget build(BuildContext context) {
    // debugPrint(animalAd.toString());
 
    return ListTile(
      title: Text(animalAd.userEmail),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.delete), 
              color: Theme.of(context).errorColor,
              onPressed:(){
                showDialog(
                  context: context, 
                  builder: (ctx) =>AlertDialog(
                    title: Text('Excluir usuário'),
                    content: Text('Tem certeza?'),
                    actions: [
                      TextButton(
                        child: Text('Não'),
                        onPressed: () => Navigator.of(ctx).pop(), 
                      ),
                      TextButton(
                        child: Text('Sim'),
                        onPressed: () { 
                          Provider.of<AnimalAdList>(context, listen: false).removeUser(animalAd);
                          Navigator.of(ctx).pop();
                        }
                      ),
                    ],
                  ),
                );
              }, 
            ),
          ],
        ),
      ),
    );
  }
}