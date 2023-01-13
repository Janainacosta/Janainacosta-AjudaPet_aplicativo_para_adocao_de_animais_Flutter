import 'package:ajudapet/components/app_drawer.dart';
import 'package:ajudapet/components/padrinho_grid.dart';
import 'package:ajudapet/models/padrinho_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions{
  Favorite,
  All,
}

class GridPadrinho extends StatefulWidget {  
  GridPadrinho({super.key});

  @override
  State<GridPadrinho> createState() => _GridPadrinhoState();
}

class _GridPadrinhoState extends State<GridPadrinho> {
  bool _showFavoriteOnly = false;
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<PadrinhoList>(
      context,
      listen: false,
    ).loadPadrinho().then((value){
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
       title: Text('SEJA PADRINHO! Ajude animais que' '\n' 
        'precisam de ajuda financeira',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
        ),
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
      ) : PadrinhoGrid(_showFavoriteOnly), 
      drawer: AppDrawer(),
    );
  }
}

