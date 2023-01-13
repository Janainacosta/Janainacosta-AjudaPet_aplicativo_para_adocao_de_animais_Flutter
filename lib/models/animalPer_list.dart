import 'dart:convert';
import 'dart:math';

import 'package:ajudapet/models/animalPer_model.dart';
import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnimalPerList with ChangeNotifier{

  String _token;
  String? emailUser = Auth.emailUserForm;
  List<AnimalPerModel> _items = [];
 
  List<AnimalPerModel> get items => [..._items];
  List<AnimalPerModel> get FavoriteItems => _items.where((prod) => prod.isFavorite).toList();

  AnimalPerList(this._token, this._items);
  
  int get itemsCount{
    return _items.length;
  }

  Future<void> loadAnimalPer() async{
    _items.clear();
    
    final response = await http.get(
      Uri.parse('${Constants.ANIMALPER_BASE_URL}.json?auth=$_token'));
    if(response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((animalPerId, animalPerData) { 
      _items.add(
        AnimalPerModel(
          idAnimalPer: animalPerId,
          emailUser: animalPerData['emailUser'] == ''  || animalPerData['emailUser'] == ''? emailUser.toString() : animalPerData['emailUser'],
          nome: animalPerData['nome'], 
          nomeResp: animalPerData['nomeResp'],
          contatoResp: animalPerData['contatoResp'],
          descricao: animalPerData['descricao'],
          imagem: animalPerData['imagem'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveAnimalPer(Map<String, Object> data){
    bool hasId = data['idAnimalPer'] != null;

    final newAnimalPer = AnimalPerModel(
      idAnimalPer: hasId? data['idAnimalPer'] as String : Random().nextDouble().toString(), 
      emailUser: data['emailUser'].toString(),
      nome: data['nome'] as String, 
      nomeResp: data['nomeResp'] as String,  
      contatoResp: data['contatoResp'] as String, 
      descricao:data['descricao'] as String, 
      imagem: data['imagem'] as String, 
    );

    if(hasId){
      return updateAnimalPer(newAnimalPer);
    }else{
      return addAnimalPer(newAnimalPer);
    }

  }

  Future<void> addAnimalPer(AnimalPerModel animalPer) async{
    final response = await http.post(
      Uri.parse('${Constants.ANIMALPER_BASE_URL}.json?auth=$_token'),
      body: jsonEncode(
        {
          "imagem": animalPer.imagem,
          "emailUser": animalPer.emailUser != null ? emailUser.toString() : animalPer.emailUser,
          "nome": animalPer.nome,
          "nomeResp": animalPer.nomeResp,
          "contatoResp": animalPer.contatoResp,
          "descricao": animalPer.descricao,
          "isFavorite": animalPer.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
      _items.add(AnimalPerModel(
        idAnimalPer: id, 
        emailUser:animalPer.emailUser == '' ? emailUser.toString() : animalPer.emailUser,
        nome: animalPer.nome, 
        nomeResp: animalPer.nomeResp, 
        contatoResp: animalPer.contatoResp, 
        descricao: animalPer.descricao, 
        imagem: animalPer.imagem,
        isFavorite: animalPer.isFavorite,
      ));
    notifyListeners();
    
  }

  Future<void> updateAnimalPer(AnimalPerModel animalPer) async{
   int index = _items.indexWhere((p) => p.idAnimalPer == animalPer.idAnimalPer);

   if(index >= 0){
      await http.patch(
      Uri.parse('${Constants.ANIMALPER_BASE_URL}/${animalPer.idAnimalPer}.json?auth=$_token'),
      body: jsonEncode(
        {
          "imagem": animalPer.imagem,
          "nome": animalPer.nome,
          "nomeResp": animalPer.nomeResp,
          "contatoResp": animalPer.contatoResp,
          "descricao": animalPer.descricao,
        },
      ),
    );
     _items[index] = animalPer;
     notifyListeners();
   }
  }

  Future<void> removeAnimalPer(AnimalPerModel animalPer) async{
   int index = _items.indexWhere((p) => p.idAnimalPer == animalPer.idAnimalPer);

   if(index >= 0){
     await http.delete(
      Uri.parse('${Constants.ANIMALPER_BASE_URL}/${animalPer.idAnimalPer}.json?auth=$_token'),
    );
      _items.removeWhere((p) => p.idAnimalPer == animalPer.idAnimalPer);
     notifyListeners();
   }
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