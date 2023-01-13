import 'package:ajudapet/components/animalAd_item.dart';
import 'package:ajudapet/components/app_drawer.dart';
import 'package:ajudapet/models/animalAd_list.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/animalAd_model.dart';
import '../models/auth.dart';

class AnimalAdPage extends StatelessWidget {
  const AnimalAdPage({super.key});
  @override
  Widget build(BuildContext context) {
    final AnimalAdList animalAd = Provider.of(context);
    String? loggedEmail = Auth.emailUserForm;
    animalAd.items.removeWhere((item) => item.emailUser == 'jana@gmail.com');
    
    for (var cadastros in animalAd.items) {
     debugPrint('cadastros.emailUser.toString()');
     debugPrint(cadastros.emailUser.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastros pets adoção'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.ANIMALADFORM);
            }, 
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding:  const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: animalAd.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [              
              AnimalAdItem(animalAd.items[i]),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}