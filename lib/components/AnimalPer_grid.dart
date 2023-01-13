import 'package:ajudapet/components/animalPer_grid_item.dart';
import 'package:ajudapet/models/animalPer_list.dart';
import 'package:ajudapet/models/animalPer_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalPerGrid extends StatelessWidget {

  final bool showFavoriteOnly;

  AnimalPerGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnimalPerList>(context);
    final List<AnimalPerModel> loadedProducts = showFavoriteOnly ? provider.FavoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: AnimalPerGridItem(),
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