import 'package:ajudapet/models/animalPer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesAnimalPerPage extends StatelessWidget {
  const DetalhesAnimalPerPage({ super.key});

  @override
  Widget build(BuildContext context) {
    final AnimalPerModel animalPer = ModalRoute.of(context)!.settings.arguments as AnimalPerModel;
    
    openWhats() async{
      var whatsapp = " +55";
      var whatsappUrl = "whatsapp://send?phone="+whatsapp+animalPer.contatoResp;
      await launch(whatsappUrl);
      
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(animalPer.nome),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(animalPer.imagem,
              fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
              Text('Nome do pet: ${animalPer.nome}',
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
                'Nome do responsável: ${animalPer.nomeResp}',
                textAlign: TextAlign.center,
              ),
            ),   
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Contato do responsável: ${animalPer.contatoResp}',
                textAlign: TextAlign.center,
              ),
            ),  
            // SizedBox(height: 10),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   width: double.infinity,
            //   child: Text(
            //     'Endereço do responsável: ${animalPer.enderecoResp}',
            //     textAlign: TextAlign.center,
            //   ),
            // ),          
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Descrição do pet: ${animalPer.descricao}',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
              TextButton(
                style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                ),
                child: Text(
                'Entrar em contato',
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