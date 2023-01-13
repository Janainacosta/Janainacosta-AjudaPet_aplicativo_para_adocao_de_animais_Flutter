import 'package:ajudapet/components/animalAd_item.dart';
import 'package:ajudapet/components/animalPer_item.dart';
import 'package:ajudapet/components/app_drawer.dart';
import 'package:ajudapet/components/padrinho_item.dart';
import 'package:ajudapet/models/animalPer_list.dart';
import 'package:ajudapet/models/padrinho_list.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PadrinhoPage extends StatelessWidget {
  const PadrinhoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PadrinhoList padrinho = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastros animais da ONG''\n'
          'que precisam de ajuda financeira' ,
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.PADRINHOFORM);
            }, 
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding:  const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: padrinho.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              PadrinhoItem(padrinho.items[i]),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}