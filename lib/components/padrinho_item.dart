import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/models/padrinho_list.dart';
import 'package:ajudapet/models/padrinho_model.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PadrinhoItem extends StatelessWidget {
  final PadrinhoModel padrinho;
  const PadrinhoItem(this.padrinho, { super.key});

  @override
  Widget build(BuildContext context) {
    String? loggedEmail = Auth.emailUserForm;
    bool verify;
    if(loggedEmail == padrinho.emailUser || loggedEmail == 'jana@gmail.com')
    verify = true;
    else
    verify = false;
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(padrinho.imagem),
      ),
      title: Text(padrinho.nome),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(!verify ? null :Icons.edit), 
              color: Theme.of(context).primaryColor,
              onPressed:!verify ? null : (){
                Navigator.of(context).pushNamed(AppRoutes.PADRINHOFORM, arguments: padrinho);
              }, 
            ),
            IconButton(
              icon: Icon(!verify ? null :Icons.delete), 
              color: Theme.of(context).errorColor,
              onPressed:!verify ? null : (){
                showDialog(
                  context: context, 
                  builder: (ctx) =>AlertDialog(
                    title: Text('Excluir animal'),
                    content: Text('Tem certeza?'),
                    actions: [
                      TextButton(
                        child: Text('Não'),
                        onPressed: () => Navigator.of(ctx).pop(), 
                      ),
                      TextButton(
                        child: Text('Sim'),
                        onPressed: () { 
                          Provider.of<PadrinhoList>(context, listen: false).removePadrinho(padrinho);
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