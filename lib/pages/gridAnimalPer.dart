import 'package:ajudapet/components/AnimalPer_grid.dart';
import 'package:ajudapet/components/app_drawer.dart';
import 'package:ajudapet/models/animalPer_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions{
  Favorite,
  All,
}

class GridAnimalPer extends StatefulWidget {  
  GridAnimalPer({super.key});

  @override
  State<GridAnimalPer> createState() => _GridAnimalPerState();
}

class _GridAnimalPerState extends State<GridAnimalPer> {
  bool _showFavoriteOnly = false;
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<AnimalPerList>(
      context,
      listen: false,
    ).loadAnimalPer().then((value){
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
        title: Text('Animais perdidos'),
        // actions: [
        //   PopupMenuButton(
        //     itemBuilder: (_) => [
        //       PopupMenuItem(
        //         child: Text('Favoritos'),
        //         value: FilterOptions.Favorite,
        //       ),
        //       PopupMenuItem(
        //         child: Text('Todos'),
        //         value: FilterOptions.All,
        //       ),
        //     ],
        //     onSelected: (FilterOptions selectedValue){
        //       setState(() {
        //         if (selectedValue == FilterOptions.Favorite) {
        //             _showFavoriteOnly = true;
        //         } else{
        //             _showFavoriteOnly = false;
        //         }
        //       });
        //       // if (selectedValue == FilterOptions.Favorite) {
        //       //   //provider.showFavoriteOnly();
        //       // } else{
        //       //   //provider.showAll();
        //       // }
        //     },
        //   ),
        //   // Consumer<Cart>(
        //   //   child: IconButton(
        //   //       onPressed: (){
        //   //         Navigator.of(context).pushNamed(AppRoutes.CART);
        //   //       }, 
        //   //       icon: Icon(Icons.pets),
        //   //     ),
        //   //   builder: (ctx, cart, child) => Badge(
        //   //     value:  cart.itemsCount.toString(),
        //   //     child: child!,
        //   //   ),
        //   // )
        // ],
      ),
      body: _isloading ? Center(
        child: CircularProgressIndicator()
      ) : AnimalPerGrid(_showFavoriteOnly), 
      drawer: AppDrawer(),
    );
  }
}

