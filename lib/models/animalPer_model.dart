  import 'package:flutter/cupertino.dart';

class AnimalPerModel with ChangeNotifier{
  final String idAnimalPer;
  final String emailUser;
  final String nome;
  final String nomeResp;
  final String contatoResp;
  final String descricao;
  final String imagem;
    bool isFavorite;

  AnimalPerModel({
    required this.idAnimalPer,
    required this.emailUser,
    required this.nome,
    required this.nomeResp,
    required this.contatoResp,
    required this.descricao,
    required this.imagem,
    this.isFavorite = false,

  });

}