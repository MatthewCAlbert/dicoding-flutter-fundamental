import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restofulist/data/api/api_service.dart';
import 'package:restofulist/data/model/api/restaurant_list.dart';
import 'package:restofulist/provider/restaurant_provider.dart';
import 'package:restofulist/ui/components/platform_widget.dart';
import 'package:restofulist/ui/components/restaurant_item.dart';
import 'package:restofulist/ui/screens/restaurant_detail_page.dart';
import 'package:restofulist/ui/screens/restaurant_search_page.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurants';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildList(BuildContext context, List<RestaurantShortVersion> data) {
    // build list
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return RestaurantItem(
            restaurant: data[index],
            onTap: () {
              Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                  arguments: data[index].id);
            });
      },
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
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
            icon: const Icon(Icons.search),
            label: const Text('Search'),
          ),
          const SizedBox(height: 20),
          Consumer<RestaurantListProvider>(builder: (context, provider, child) {
            if (provider.state == ApiResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.state == ApiResultState.hasData) {
              return Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                      Text('${provider.result.restaurants.length} place',
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontWeight: FontWeight.w300,
                                  )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildList(context, provider.result.restaurants),
                  ),
                ],
              ));
            } else if (provider.state == ApiResultState.noData) {
              return Center(
                child: Text(
                  'No restaurant found',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
              );
            } else if (provider.state == ApiResultState.error) {
              return Center(
                child: Text(
                  'Failed to load restaurant list',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
              );
            } else if (provider.state == ApiResultState.noInternet) {
              return Center(
                child: Text(
                  'No Internet Connection',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Nothing to see here',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
              );
            }
          }),
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
