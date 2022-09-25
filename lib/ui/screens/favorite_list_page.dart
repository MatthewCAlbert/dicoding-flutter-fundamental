import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restofulist/data/api/api_service.dart';
import 'package:restofulist/data/model/api/restaurant_list.dart';
import 'package:restofulist/provider/database_provider.dart';
import 'package:restofulist/ui/components/platform_widget.dart';
import 'package:restofulist/ui/components/restaurant_item.dart';
import 'package:restofulist/ui/screens/restaurant_detail_page.dart';

class FavoriteListPage extends StatefulWidget {
  static const routeName = '/favorite_list';

  const FavoriteListPage({Key? key}) : super(key: key);

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
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
            'My Favorites',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20),
          Consumer<DatabaseProvider>(builder: (context, provider, child) {
            if (provider.state == ApiResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.state == ApiResultState.hasData) {
              return Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildList(context, provider.favorites),
                  ),
                ],
              ));
            } else if (provider.state == ApiResultState.noData) {
              return Center(
                child: Text(
                  'No favorite restaurant found',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
              );
            } else if (provider.state == ApiResultState.error) {
              print(provider.message);
              return Center(
                child: Text(
                  'Failed to load favorite restaurant list',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  provider.message,
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
