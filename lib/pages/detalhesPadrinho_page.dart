import 'package:ajudapet/models/animalPer_model.dart';
import 'package:ajudapet/models/padrinho_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetalhesPadrinhoPage extends StatelessWidget {
  const DetalhesPadrinhoPage({ super.key});

  @override
  Widget build(BuildContext context) {
    final PadrinhoModel padrinho = ModalRoute.of(context)!.settings.arguments as PadrinhoModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(padrinho.nome),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(padrinho.imagem,
              fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
              Text('Nome do pet: ${padrinho.nome}',
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
                'Nome do responsável: ${padrinho.nomeResp}',
                textAlign: TextAlign.center,
              ),
            ),   
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Contato do responsável: ${padrinho.contatoResp}',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Cidade: ${padrinho.cidade}',
                textAlign: TextAlign.center,
              ),
            ),           
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Descrição do pet: ${padrinho.descricao}',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Conta Bancária da ONG: ${padrinho.contaBancaria}',
                textAlign: TextAlign.center,
              ),
            ), 
          ],
        ),
      ),
    );
  }
}