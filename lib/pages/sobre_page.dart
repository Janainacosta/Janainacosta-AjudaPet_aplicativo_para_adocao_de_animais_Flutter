import 'package:ajudapet/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o aplicativo'),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                    width: 400,
                    height: 590,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text("O aplicativo AJUDAPET foi criado para ajudar na adoção e resgate de animais."'\n''\n' 
                        "Aluna: Janaína Barbosa da Costa"'\n' 
                        "Orientador: Tiago Gonçalves Botelho"'\n'
                        "Trabalho de Conclusão de Curso"'\n'   
                        "Ciência da Computação"'\n'
                        "IFSULDEMINAS - Campus Muzambinho"'\n' '\n' 
                        "Como o aplicativo funciona?" '\n' '\n' 
                        "--O usuário pode cadastrar animais para adoção."'\n''\n'
                        "--O usuário pode cadastrar animais perdidos."'\n''\n'
                        "--Com as contas das ONGs ou contas dos voluntários cadastrados, é possível fazer doaçoes."'\n''\n'
                        "--As ONGs ou voluntários podem cadastrar animais que precisem de ajuda financeira na página de seja padrinho para receberem ajuda."'\n',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                        )
                        ),
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}