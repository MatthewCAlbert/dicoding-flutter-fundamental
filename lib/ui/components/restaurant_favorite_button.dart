import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restofulist/data/model/api/restaurant_list.dart';
import 'package:restofulist/provider/database_provider.dart';

extension IterableModifier<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) =>
      cast<E?>().firstWhere((v) => v != null && test(v), orElse: () => null);
}

class RestaurantFavoriteButton extends StatelessWidget {
  const RestaurantFavoriteButton({Key? key, required this.restaurant})
      : super(key: key);
  final RestaurantShortVersion restaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(builder: (context, snapshot) {
        var isFavorited = provider.favorites.firstWhereOrNull(
                    (element) => element.id == restaurant.id) !=
                null
            ? true
            : false;
        return IconButton(
            color: isFavorited ? Colors.red : Colors.grey,
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
            ),
            onPressed: () {
              if (isFavorited) {
                provider.removeFavorite(restaurant.id);
              } else {
                provider.addFavorite(restaurant);
              }
            });
      });
    });
  }
}
