import 'package:ajudapet/components/padrinho_grid_item.dart';
import 'package:ajudapet/models/padrinho_list.dart';
import 'package:ajudapet/models/padrinho_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PadrinhoGrid extends StatelessWidget {

  final bool showFavoriteOnly;

  PadrinhoGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PadrinhoList>(context);
    final List<PadrinhoModel> loadedProducts = showFavoriteOnly ? provider.FavoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: PadrinhoGridItem(),
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