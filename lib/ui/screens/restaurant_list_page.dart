import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restofulist/common/styles.dart';
import 'package:restofulist/data/model/restaurant.dart';
import 'package:restofulist/ui/components/platform_widget.dart';
import 'package:restofulist/ui/screens/restaurant_detail_page.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurants';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final TextEditingController _searchQueryController = TextEditingController();
  List<Restaurant> _queryResults = [];

  @override
  void initState() {
    super.initState();
    _findByNameQuery();

    // Start listening to changes.
    _searchQueryController.addListener(_findByNameQuery);
  }

  @override
  void dispose() {
    _searchQueryController.dispose();
    super.dispose();
  }

  void _findByNameQuery() {
    DefaultAssetBundle.of(context)
        .loadString('assets/data/local_restaurant.json')
        .then((json) {
      final List<Restaurant> restaurants = parseRestaurants(json);
      List<Restaurant> res = [];
      for (int i = 0; i < restaurants.length; i++) {
        var e = restaurants[i];
        if (e.name.contains(
            RegExp(_searchQueryController.text, caseSensitive: false))) {
          res.add(e);
        }
      }
      setState(() {
        _queryResults = res;
      });
    });
  }

  Widget _buildList(BuildContext context) {
    // build list
    return ListView.builder(
      itemCount: _queryResults.length,
      itemBuilder: (context, index) {
        final restaurant = _queryResults[index];
        return _buildRestaurantItem(context, _queryResults[index]);
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
      color: primaryColor,
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
                            restaurant.pictureId,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
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
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.red,
                          ),
                          child: Text(
                            '${restaurant.menus.foods.length.toString()} Foods',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: secondaryRed,
                          ),
                          child: Text(
                            '${restaurant.menus.drinks.length.toString()} Drinks',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            'Restofulist',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            'a pique interest',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(31, 0, 0, 0),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 24.0,
                  semanticLabel: 'Search Symbol',
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    child: Material(
                  child: TextField(
                    controller: _searchQueryController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Find restaurant...'),
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Available',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text('${_queryResults.length} place',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w300,
                      )),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _buildList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: _buildContent(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
