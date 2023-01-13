import 'dart:convert';
import 'dart:math';

import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/models/padrinho_model.dart';
import 'package:ajudapet/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PadrinhoList with ChangeNotifier{

  String _token;
  String? emailUser = Auth.emailUserForm;
  List<PadrinhoModel> _items = [];
 
  List<PadrinhoModel> get items => [..._items];
  List<PadrinhoModel> get FavoriteItems => _items.where((prod) => prod.isFavorite).toList();

  PadrinhoList(this._token, this._items);
  
  int get itemsCount{
    return _items.length;
  }

  Future<void> loadPadrinho() async{
    _items.clear();
    
    final response = await http.get(
      Uri.parse('${Constants.PADRINHO_BASE_URL}.json?auth=$_token'));
    if(response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((padrinhoId, padrinhoData) { 
      _items.add(
        PadrinhoModel(
          idPadrinho: padrinhoId,
          emailUser: padrinhoData['emailUser'] == ''  || padrinhoData['emailUser'] == ''? emailUser.toString() : padrinhoData['emailUser'],
          nome: padrinhoData['nome'], 
          nomeResp: padrinhoData['nomeResp'], 
          contatoResp: padrinhoData['contatoResp'], 
          cidade: padrinhoData['cidade'],  
          descricao: padrinhoData['descricao'], 
          contaBancaria: padrinhoData['contaBancaria'], 
          imagem: padrinhoData['imagem'], 
        ),
      );
    });
    notifyListeners();
  }

  Future<void> savePadrinho(Map<String, Object> data){
    bool hasId = data['idPadrinho'] != null;

    final newPadrinho = PadrinhoModel(
      idPadrinho: hasId? data['idPadrinho'] as String : Random().nextDouble().toString(), 
      emailUser: data['emailUser'].toString(), 
      nome: data['nome'] as String, 
      nomeResp: data['nomeResp'] as String,  
      contatoResp: data['contatoResp'] as String, 
      cidade: data['cidade'] as String,
      descricao: data['descricao'] as String, 
      contaBancaria: data['contaBancaria'] as String, 
      imagem: data['imagem'] as String,
    );
    
    if(hasId){
      return updatePadrinho(newPadrinho);
    }else{
      return addPadrinho(newPadrinho);
    }

  }

  Future<void> addPadrinho(PadrinhoModel padrinho) async{
    final response = await http.post(
      Uri.parse('${Constants.PADRINHO_BASE_URL}.json?auth=$_token'),
      body: jsonEncode(
        {
          "emailUser": padrinho.emailUser != null ? emailUser.toString() : padrinho.emailUser,
          "imagem": padrinho.imagem,
          "nome": padrinho.nome,
          "nomeResp": padrinho.nomeResp,
          "contatoResp": padrinho.contatoResp,
          "cidade": padrinho.cidade,
          "descricao": padrinho.descricao,
          "contaBancaria": padrinho.contaBancaria,
          "isFavorite": padrinho.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
      _items.add(PadrinhoModel(
        idPadrinho: id, 
        emailUser:padrinho.emailUser == '' ? emailUser.toString() : padrinho.emailUser,
        nome: padrinho.nome, 
        nomeResp: padrinho.nomeResp, 
        contatoResp: padrinho.contatoResp, 
        cidade: padrinho.cidade, 
        descricao: padrinho.descricao,  
        contaBancaria: padrinho.contaBancaria,  
        imagem: padrinho.imagem, 
      ));
    notifyListeners();
  }

  Future<void> updatePadrinho(PadrinhoModel padrinho) async{
   int index = _items.indexWhere((p) => p.idPadrinho == padrinho.idPadrinho);

   if(index >= 0){
      await http.patch(
      Uri.parse('${Constants.PADRINHO_BASE_URL}/${padrinho.idPadrinho}.json?auth=$_token'),
      body: jsonEncode(
        {
          "imagem": padrinho.imagem,
          "nome": padrinho.nome, 
          "nomeResp": padrinho.nomeResp, 
          "contatoResp": padrinho.contatoResp, 
          "cidade": padrinho.cidade, 
          "descricao": padrinho.descricao,  
          "contaBancaria": padrinho.contaBancaria,
        },
      ),
    );
     _items[index] = padrinho;
     notifyListeners();
   }
  }

  Future<void> removePadrinho(PadrinhoModel padrinho) async{
   int index = _items.indexWhere((p) => p.idPadrinho == padrinho.idPadrinho);

   if(index >= 0){
     await http.delete(
      Uri.parse('${Constants.PADRINHO_BASE_URL}/${padrinho.idPadrinho}.json?auth=$_token'),
    );
      _items.removeWhere((p) => p.idPadrinho == padrinho.idPadrinho);
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