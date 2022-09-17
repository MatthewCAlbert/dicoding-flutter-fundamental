import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restofulist/data/api/api_service.dart';
import 'package:restofulist/data/model/api/restaurant_list.dart';
import 'package:restofulist/provider/restaurant_provider.dart';
import 'package:restofulist/ui/components/restaurant_item.dart';
import 'package:restofulist/ui/screens/restaurant_detail_page.dart';

class RestaurantSearchResult extends StatelessWidget {
  const RestaurantSearchResult({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
        builder: (context, provider, child) {
      if (provider.state == ApiResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (provider.state == ApiResultState.hasData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Found',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text('${provider.result.restaurants.length} place',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w300,
                        )),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildList(context, provider.result.restaurants),
            ),
          ],
        );
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
            'An error occured',
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
    });
  }
}
