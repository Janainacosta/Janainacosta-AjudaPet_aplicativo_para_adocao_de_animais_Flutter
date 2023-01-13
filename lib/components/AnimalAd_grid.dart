import 'package:ajudapet/components/animalAd_grid_item.dart';
import 'package:ajudapet/models/animalAd_list.dart';
import 'package:ajudapet/models/animalAd_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalAdGrid extends StatelessWidget {

  final bool showFavoriteOnly;

  AnimalAdGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnimalAdList>(context);
    final List<AnimalAdModel> loadedProducts = showFavoriteOnly ? provider.FavoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: AnimalAdGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
       childAspectRatio: 3/2,
       crossAxisSpacing: 10,
       mainAxisSpacing: 10,
      ),
    );
  }
}