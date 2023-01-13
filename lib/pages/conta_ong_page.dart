import 'package:ajudapet/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContaOngPage extends StatelessWidget {
  const ContaOngPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contas bancárias ONGs'),
      ),
      drawer: AppDrawer(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [ 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: Text(
                      "Ajude uma ONG!! Aqui estão os dados bancários para doações.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                  width: 300,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text("Voluntários da Corrente Do Bem Muzambinho - MG" '\n' '\n' 
                    "Pix CPF: 05661620675"'\n' '\n'
                    "Jacqueline Vechi Vilela Kraus de Oliveira",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                    )
                    ),
                  ),
                  Divider(),
                  Container(
                  width: 300,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text("APPA-BJP- Associação dos Protetores dos Animais de Bom Jesus da Penha - MG" '\n''\n' 
                    "Pix CPF:  49919024600"'\n' '\n'
                    "Rosali",
                    style: TextStyle(fontSize: 18), 
                    textAlign: TextAlign.center,)
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
    );
  }
}