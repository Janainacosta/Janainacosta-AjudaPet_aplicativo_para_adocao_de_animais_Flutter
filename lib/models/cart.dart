import 'dart:math';

import 'package:ajudapet/models/animalAd_model.dart';
import 'package:ajudapet/models/cart_item.dart';
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier{
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items{
    return {..._items};
  }

  int get itemsCount{
    return _items.length;
  }

  // double get totalAmount{
  //   double total = 0.0;
  //   _items.forEach((key, CartItem) {
  //     total += CartItem.price * CartItem.quantity;
  //   });
  //    return total;
  // }
   
  void addItem(AnimalAdModel animalAd){
    if(_items.containsKey(animalAd.idAnimalAd)){
      _items.update(animalAd.idAnimalAd, 
      (existingItem) => CartItem(
        idAnimalAd: existingItem.idAnimalAd,
        animalAdId: existingItem.animalAdId,
        nome: existingItem.nome, 
        nomeResp: existingItem.nomeResp, 
        contatoResp: existingItem.contatoResp, 
        enderecoResp: existingItem.enderecoResp, 
        descricao: existingItem.descricao,
        ),
      );
    } else{
      _items.putIfAbsent(animalAd.idAnimalAd, 
      () => CartItem(
        idAnimalAd: Random().nextDouble.toString(),
        animalAdId: animalAd.idAnimalAd, 
        nome: animalAd.nome, 
        nomeResp: animalAd.nomeResp, 
        contatoResp: animalAd.contatoResp, 
        enderecoResp: animalAd.enderecoResp, 
        descricao: animalAd.descricao,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String animalAdId){
    _items.remove(animalAdId);
    notifyListeners();
  }

  void removeSingleItem(String animalAdId){
    if(!_items.containsKey(animalAdId)){
      return;
    }

     if(_items[animalAdId]?.idAnimalAd == 1){
       _items.remove(animalAdId);
     }else{
       _items.update(animalAdId, 
      (existingItem) => CartItem(
        idAnimalAd: existingItem.idAnimalAd,
        animalAdId: existingItem.animalAdId,
        nome: existingItem.nome, 
        nomeResp: existingItem.nomeResp, 
        contatoResp: existingItem.contatoResp, 
        enderecoResp: existingItem.enderecoResp, 
        descricao: existingItem.descricao,
        ),
      );
    }
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }

}