import 'dart:io';

import 'package:ajudapet/components/AnimalAd_grid.dart';
import 'package:ajudapet/components/app_drawer.dart';
import 'package:ajudapet/components/badge.dart';
import 'package:ajudapet/models/animalAd_list.dart';
import 'package:ajudapet/models/cart.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions{
  Favorite,
  All,
}

class GridAnimalAd extends StatefulWidget {  
  GridAnimalAd({super.key});

  @override
  State<GridAnimalAd> createState() => _GridAnimalAdState();
}

class _GridAnimalAdState extends State<GridAnimalAd> {
  bool _showFavoriteOnly = false;
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<AnimalAdList>(
      context,
      listen: false,
    ).loadAnimalAd().then((value){
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<AnimalAdList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Animais para adoção'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                    _showFavoriteOnly = true;
                } else{
                    _showFavoriteOnly = false;
                }
              });
              // if (selectedValue == FilterOptions.Favorite) {
              //   //provider.showFavoriteOnly();
              // } else{
              //   //provider.showAll();
              // }
            },
          ),
          // Consumer<Cart>(
          //   child: IconButton(
          //       onPressed: (){
          //         Navigator.of(context).pushNamed(AppRoutes.CART);
          //       }, 
          //       icon: Icon(Icons.pets),
          //     ),
          //   builder: (ctx, cart, child) => Badge(
          //     value:  cart.itemsCount.toString(),
          //     child: child!,
          //   ),
          // )
        ],
      ),
      body: _isloading ? Center(
        child: CircularProgressIndicator()
      ) : AnimalAdGrid(_showFavoriteOnly), 
      drawer: AppDrawer(),
    );
  }
}

