import 'dart:convert';
import 'dart:io';

import 'package:ajudapet/providers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AnimalAdModel with ChangeNotifier{
  final String idAnimalAd;
  final String emailUser;
  final String nome;
  final String nomeResp;
  final String contatoResp;
  final String enderecoResp;
  final String descricao;
  final String imagem;
  //final File image;
  bool isFavorite;

  AnimalAdModel({
    required this.emailUser,
    required this.idAnimalAd,
    required this.nome,
    required this.nomeResp,
    required this.contatoResp,
    required this.enderecoResp,
    required this.descricao,
    required this.imagem,
   //required this.image,
    this.isFavorite = false,
  });

  void _togglefavorite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token) async{
    _togglefavorite();

    final response = await http.patch(
      Uri.parse('${Constants.ANIMALAD_BASE_URL}/$idAnimalAd.json?auth=$token'),
      body: jsonEncode(
        {
          "isFavorite": isFavorite,
        },
      ),
    );
    if (response.statusCode >= 400){
      _togglefavorite();
    }
  }
}