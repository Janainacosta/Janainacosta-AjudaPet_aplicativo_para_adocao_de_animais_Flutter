import 'package:flutter/material.dart';

class Usuario  with ChangeNotifier{
  final String idData;
  final String userEmail;
  final String uid;
  Usuario({    
    required this.idData,
    required this.userEmail,
    required this.uid,
  });
}