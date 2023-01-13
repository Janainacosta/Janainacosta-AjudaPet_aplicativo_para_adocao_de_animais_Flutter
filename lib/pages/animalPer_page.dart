import 'package:ajudapet/components/animalAd_item.dart';
import 'package:ajudapet/components/animalPer_item.dart';
import 'package:ajudapet/components/app_drawer.dart';
import 'package:ajudapet/models/animalPer_list.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalPerPage extends StatelessWidget {
  const AnimalPerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimalPerList animalPer = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastros pets perdidos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.ANIMALPERFORM);
            }, 
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding:  const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: animalPer.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              AnimalPerItem(animalPer.items[i]),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}