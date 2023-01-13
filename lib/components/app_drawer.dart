import 'package:ajudapet/models/animalAd_list.dart';
import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({ super.key});

  @override
  Widget build(BuildContext context) {
    final AnimalAdList animalAd = Provider.of(context);
    String? loggedEmail = Auth.emailUserForm;
    bool verify;
  if(loggedEmail == 'jana@gmail.com')
  verify = true;
  else
  verify = false;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: !verify ? Text('Bem vindo!') : Text('Bem vindo Administrador!'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Animais para adoção'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
              },
            ),
             Divider(),
            ListTile(
              leading: Icon(Icons.pets),
              title: Text('Animais perdidos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.HOMEANIMAISPER);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Contas Bancárias ONGs'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.CONTAONGPAGE);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.co_present_rounded),
              title: Text('Seja Padrinho'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.GRIDPADRINHO);
              },
            ),
             Divider(),
            ListTile(
              leading: Icon(Icons.my_library_books),
              title: Text('Sobre o aplicativo'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.SOBREPAGE);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Cadastros animais para adoção'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.ANIMALADPAGE);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Cadastros animais perdidos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.ANIMALPERPAGE);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Cadastros para o seja padrinho'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.PADRINHOPAGE);
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: !verify ? null : ListTile (
                leading: Icon( Icons.person),
                title: Text('Gerenciar usuários'),
                onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.GERENCIARUSUARIOS);
              },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
              },
            ),
          ],
        ),
      ),
    );
  }
}