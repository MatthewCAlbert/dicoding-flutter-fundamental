import 'package:flutter/material.dart';
import 'package:restofulist/data/api/api_service.dart';
import 'package:restofulist/data/model/api/restaurant_list.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem(
      {Key? key, required this.restaurant, required this.onTap})
      : super(key: key);

  final RestaurantShortVersion restaurant;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        subtitle: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Hero(
                  tag: restaurant.id,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            ApiService.getPictureUrl(restaurant.pictureId),
                            width: 110,
                            height: 72,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 5,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
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
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ],
                ))
              ],
            )),
        onTap: onTap as void Function()?,
      ),
    );
  }
}
