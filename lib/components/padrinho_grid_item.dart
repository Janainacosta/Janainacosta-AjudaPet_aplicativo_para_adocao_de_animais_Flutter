import 'package:ajudapet/models/cart.dart';
import 'package:ajudapet/models/padrinho_model.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PadrinhoGridItem extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final padrinho = Provider.of<PadrinhoModel>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(padrinho.imagem,
          fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
             AppRoutes.DETALHESPADRINHOPAGE,
             arguments: padrinho,
            );
          },
        ),
        footer: GridTileBar(
          title: Text(padrinho.nome,
          textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          // leading: Consumer<AnimalPerModel>(
          //   builder: (ctx, animalPer, _) => IconButton(
          //     onPressed: (){
          //       animalPer.toggleFavorite();
          //     },
          //     icon: Icon(animalPer.isFavorite ? Icons.favorite : Icons.favorite_border),
          //     color: Theme.of(context).accentColor,
          //   ),
          // ),
          // trailing: IconButton(
          //   icon: Icon(Icons.pets),
          //   color: Theme.of(context).accentColor,
          //   onPressed: () {
          //     cart.addItem(animalPer);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text('Animal adicionado com sucesso'),
          //       duration: Duration(seconds: 2),
          //       action: SnackBarAction(
          //         label:'DESFAZER',
          //         onPressed: (() {
          //           cart.removeSingleItem(animalPer.idAnimalPer);
          //         }),
          //       ),
          //       ),
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}