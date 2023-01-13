import 'dart:io' as io;
import 'dart:developer';

import 'package:ajudapet/models/animalAd_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';



class DetalhesAnimalAdPage extends StatelessWidget {
  DetalhesAnimalAdPage({ super.key});
  final FirebaseStorage storage = FirebaseStorage.instance;
  List<Reference> refs = [];
  List<String> arquivos = [];

  
  @override
  
  Widget build(BuildContext context) {
    final AnimalAdModel animalAd = ModalRoute.of(context)!.settings.arguments as AnimalAdModel;

    // compartilharAnimalAd() {
    // SocialShare.shareOptions(animalAd.imagem);
    // }

    
    openWhats() async{
      var whatsapp = " +55";
      var whatsappUrl = "whatsapp://send?phone="+whatsapp+animalAd.contatoResp;
      await launch(whatsappUrl);
      
    }

   loadImages() async {
    refs = (await storage.ref('imagesAnimalAd').listAll()).items;
    for (var ref in refs) {
      final arquivo = await ref.getDownloadURL();
      arquivos.add(arquivo);
      debugPrint(arquivo);
    }    
  }
 
    return Scaffold(
      appBar: AppBar(
        title: Text(animalAd.nome),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.share),
        //     onPressed: compartilharAnimalAd,
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(animalAd.imagem,
              fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
              Text('Nome do pet: ${animalAd.nome}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Nome do responsável: ${animalAd.nomeResp}',
                textAlign: TextAlign.center,
              ),
            ),   
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Contato do responsável: ${animalAd.contatoResp}',
                textAlign: TextAlign.center,
              ),
            ),  
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Endereço do responsável: ${animalAd.enderecoResp}',
                textAlign: TextAlign.center,
              ),
            ),          
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Descrição do pet: ${animalAd.descricao}',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              style: TextButton.styleFrom(
              backgroundColor: Colors.orange,
              ),
              child: Text(
              'Entrar em contato para adotar',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: openWhats,
            ),
          ],
        ),
      ),
    );
  }
}