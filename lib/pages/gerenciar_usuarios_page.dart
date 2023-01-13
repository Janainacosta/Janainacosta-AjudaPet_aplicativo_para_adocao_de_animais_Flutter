import 'package:ajudapet/components/animalAd_item.dart';
import 'package:ajudapet/components/app_drawer.dart';
import 'package:ajudapet/components/usuario_item.dart';
import 'package:ajudapet/models/animalAd_list.dart';
import 'package:ajudapet/models/usuario_model.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/animalAd_model.dart';
import '../models/auth.dart';

class GerenciarUsuariosPage extends StatelessWidget {

   
  const GerenciarUsuariosPage({super.key});
  @override
  Widget build(BuildContext context) {
    final AnimalAdList animalAd = Provider.of(context);
    // debugPrint(animalAd.users[0].uid.toString());
    animalAd.items.removeWhere((item) => item.emailUser == 'jana@gmail.com');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar usuários'),
      
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding:  const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: animalAd.itemsCountUser,
          itemBuilder: (ctx, i) => Column(
            children: [              
              UsuarioItem(animalAd.users[i]),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
