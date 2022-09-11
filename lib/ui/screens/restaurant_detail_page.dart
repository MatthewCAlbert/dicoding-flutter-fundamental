import 'package:flutter/material.dart';
import 'package:restofulist/data/model/restaurant.dart';
import 'package:restofulist/ui/components/restaurant_detail_menus.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                restaurant.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline5,
              )),
              Row(children: [
                const SizedBox(width: 4.0),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 23,
                ),
                const SizedBox(width: 5),
                Text(
                  restaurant.rating.toString(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ]),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                size: 20.0,
                semanticLabel: 'Map Icon',
              ),
              const SizedBox(width: 2.0),
              Text(
                restaurant.city,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.id, child: Image.network(restaurant.pictureId)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: Colors.grey),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  RestaurantDetailMenusView(restaurant: restaurant),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
