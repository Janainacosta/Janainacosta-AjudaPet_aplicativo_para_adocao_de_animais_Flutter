import 'package:ajudapet/models/animalAd_model.dart';
import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalAdGridItem extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final animalAd = Provider.of<AnimalAdModel>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    //final cart = Provider.of<Cart>(context, listen: false);

    List<Reference> refs = [];
    List<String> arquivos = [];

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(animalAd.imagem,
          fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
             AppRoutes.DETALHES_ANIMALAD,
             arguments: animalAd,
            );
          },
        ),
        footer: GridTileBar(
          title: Text(animalAd.nome,
          textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<AnimalAdModel>(
            builder: (ctx, animalAd, _) => IconButton(
              onPressed: (){
                animalAd.toggleFavorite(auth.token ?? '');
              },
              icon: Icon(animalAd.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
            ),
          ),
          // trailing: IconButton(
          //   icon: Icon(Icons.pets),
          //   color: Theme.of(context).accentColor,
          //   onPressed: () {
          //     cart.addItem(animalAd);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text('Animal adicionado com sucesso'),
          //       duration: Duration(seconds: 2),
          //       action: SnackBarAction(
          //         label:'DESFAZER',
          //         onPressed: (() {
          //           cart.removeSingleItem(animalAd.idAnimalAd);
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