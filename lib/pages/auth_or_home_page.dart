import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/pages/auth_page.dart';
import 'package:ajudapet/pages/gridAnimalAd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else if(snapshot.error != null){
          return Center(
            child: Text('Ocorreu um erro!'),
          );
        }else{
          return auth.isAuth ? GridAnimalAd() : AuthPage();
        }
      }
    );
  }
}