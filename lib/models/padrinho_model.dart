import 'package:flutter/material.dart';

class PadrinhoModel with ChangeNotifier{
  final String idPadrinho;
  final String emailUser;
  final String nome;
  final String nomeResp;
  final String contatoResp;
  final String cidade;
  final String descricao;
  final String contaBancaria;
  final String imagem;
      bool isFavorite;

  PadrinhoModel({
    required this.idPadrinho,
    required this.emailUser,
    required this.nome,
    required this.nomeResp,
    required this.contatoResp,
    required this.cidade,
    required this.descricao,
    required this.contaBancaria,
    required this.imagem,
    this.isFavorite = false,

  });

}