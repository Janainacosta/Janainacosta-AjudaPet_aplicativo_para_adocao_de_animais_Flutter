import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ajudapet/data/store.dart';
import 'package:ajudapet/models/animalAd_model.dart';
import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/models/usuario_model.dart';
import 'package:ajudapet/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';


class AnimalAdList with ChangeNotifier{

  String _token;
  String? emailUser = Auth.emailUserForm;
  List<AnimalAdModel> _items = [];

  List<Usuario> _users = [];
 
  List<Usuario> get users => [..._users];

  List<AnimalAdModel> get items => [..._items];
  List<AnimalAdModel> get FavoriteItems => _items.where((prod) => prod.isFavorite).toList();

  AnimalAdList(this._token, this._items, this._users);

Future<void> tryAutoLogin()async{

    final userData = await Store.getMap('userData');
  }  


  int get itemsCount{
    return _items.length;
  }
  int get itemsCountUser{
    return _users.length;
  }

  Future<void> loadAnimalAd() async{
    _items.clear();
    _users.clear();
    
    verifyUsers();
    getUsers();


    final response = await http.get(
      Uri.parse('${Constants.ANIMALAD_BASE_URL}.json?auth=$_token'));
    if(response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((animalAdId, animalAdData) { 
      _items.add(
        AnimalAdModel(
          idAnimalAd: animalAdId, 
          emailUser: animalAdData['emailUser'] == ''  || animalAdData['emailUser'] == ''? emailUser.toString() : animalAdData['emailUser'],
          nome: animalAdData['nome'], 
          nomeResp: animalAdData['nomeResp'],
          contatoResp: animalAdData['contatoResp'],
          enderecoResp: animalAdData['enderecoResp'],
          descricao: animalAdData['descricao'],
          imagem: animalAdData['imagem'].toString(),  
          isFavorite: animalAdData['isFavorite'],
        ),
      );
    });
    notifyListeners();
    
  }

  Future<void> saveAnimalAd(Map<String, Object> data){
    bool hasId = data['idAnimalAd'] != null;

    final newAnimalAd = AnimalAdModel(
      idAnimalAd: hasId? data['idAnimalAd'] as String : Random().nextDouble().toString(), 
      emailUser: data['emailUser'].toString(),
      nome: data['nome'] as String, 
      nomeResp: data['nomeResp'] as String,  
      contatoResp: data['contatoResp'] as String, 
      enderecoResp: data['enderecoResp'] as String,  
      descricao:data['descricao'] as String, 
      imagem: data['imagem'] as String,
      //image: data['image'] as File,
    );

    if(hasId){
      return updateAnimalAd(newAnimalAd);
    }else{
      return addAnimalAd(newAnimalAd);
    }

  }

  Future<void> addAnimalAd(AnimalAdModel animalAd) async{
    final response = await http.post(
      Uri.parse('${Constants.ANIMALAD_BASE_URL}.json?auth=$_token'),
      body: jsonEncode(
        {
         
          "emailUser": animalAd.emailUser != null ? emailUser.toString() : animalAd.emailUser,
          "imagem": animalAd.imagem,
          "nome": animalAd.nome,
          "nomeResp": animalAd.nomeResp,
          "contatoResp": animalAd.contatoResp,
          "enderecoResp": animalAd.enderecoResp,
          "descricao": animalAd.descricao,
          "isFavorite": animalAd.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
      _items.add(AnimalAdModel(
        idAnimalAd: id, 
        emailUser:animalAd.emailUser == '' ? emailUser.toString() : animalAd.emailUser,
        nome: animalAd.nome, 
        nomeResp: animalAd.nomeResp, 
        contatoResp: animalAd.contatoResp, 
        enderecoResp: animalAd.enderecoResp, 
        descricao: animalAd.descricao, 
        imagem: animalAd.imagem,
        //image: animalAd.image,
        isFavorite: animalAd.isFavorite,
      ));
    notifyListeners();
    
  }

  Future<void> updateAnimalAd(AnimalAdModel animalAd) async{
   int index = _items.indexWhere((p) => p.idAnimalAd == animalAd.idAnimalAd);

   if(index >= 0){
      await http.patch(
      Uri.parse('${Constants.ANIMALAD_BASE_URL}/${animalAd.idAnimalAd}.json?auth=$_token'),
      body: jsonEncode(
        {
          //"image": animalAd.image,
          "imagem": animalAd.imagem,
          "nome": animalAd.nome,
          "nomeResp": animalAd.nomeResp,
          "contatoResp": animalAd.contatoResp,
          "enderecoResp": animalAd.enderecoResp,
          "descricao": animalAd.descricao,
        },
      ),
    );
     _items[index] = animalAd;
     notifyListeners();
   }
  }

  Future<void> removeAnimalAd(AnimalAdModel animalAd) async{
   int index = _items.indexWhere((p) => p.idAnimalAd == animalAd.idAnimalAd);

   if(index >= 0){
     await http.delete(
      Uri.parse('${Constants.ANIMALAD_BASE_URL}/${animalAd.idAnimalAd}.json?auth=$_token'),
    );
      _items.removeWhere((p) => p.idAnimalAd == animalAd.idAnimalAd);
     notifyListeners();
   }
  }

  Future<void> removeUser(Usuario user) async{  
    debugPrint(user.idData.toString());
     await http.delete(
      Uri.parse('${Constants.USUARIO_BASE_URL}/${user.idData}.json?auth=$_token'),
    );
      _users.removeWhere((p) => p.uid == user.uid);
     notifyListeners();
   
  }
Future<void> addUser() async{
  final userData = await Store.getMap('userData');
    final response = await http.post(
      Uri.parse('${Constants.USUARIO_BASE_URL}.json?auth=$_token'),
      body: jsonEncode(
        {         
          "emailUser": userData['email'],
          "uid": userData['uid'],          
        },
      ),
    );
}
Future<void> verifyUsers() async{
  int cont = 0;
    final userData = await Store.getMap('userData');
    String? loggedEmail = Auth.emailUserForm;
    final responseUser = await http.get(
      Uri.parse('${Constants.USUARIO_BASE_URL}.json?auth=$_token'));
      if(responseUser.body == 'null') addUser();
      else{

      
      Map<String, dynamic> dataUser = jsonDecode(responseUser.body);
      dataUser.forEach((userId, data) { 
        debugPrint(data['emailUser'].toString());
        debugPrint(loggedEmail.toString());
        if(data['emailUser'] == loggedEmail)
        {
          cont++;
        }
        
      });
      if(cont==0)
        {
          addUser();
        }
        }
}
Future<void> getUsers() async{
  int cont = 0;
   
    final responseUser = await http.get(
      Uri.parse('${Constants.USUARIO_BASE_URL}.json?auth=$_token'));
      if(responseUser.body == 'null') return;      
      Map<String, dynamic> dataUser = jsonDecode(responseUser.body);
      dataUser.forEach((userId, data) { 
        debugPrint(data['emailUser'].toString());
         _users.add(
           Usuario(
             idData: userId,
             userEmail: data['emailUser'].toString(), 
             uid: data['uid'].toString()),
         );
       
      });
  notifyListeners();
      debugPrint(users[0].userEmail.toString());
      
      
}
}

// class AnimalAdList with ChangeNotifier{
//   List<AnimalAdModel> _items = dummyAnimalAd;
//   bool _showFavoriteOnly = false;

//   List<AnimalAdModel> get items {
//     if (_showFavoriteOnly){
//       return _items.where((prod) => prod.isFavorite).toList();
//     }
//     return [..._items];
//   }

//   void showFavoriteOnly(){
//     _showFavoriteOnly = true;
//     notifyListeners();
//   }

//   void showAll(){
//     _showFavoriteOnly = false;
//     notifyListeners();
//   }

//   void addAnimalAd(AnimalAdModel animalAd){
//     _items.add(animalAd);
//     notifyListeners();
//   }
// }