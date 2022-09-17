import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restofulist/data/api/api_service.dart';
import 'package:restofulist/data/model/restaurant.dart';
import 'package:restofulist/provider/restaurant_provider.dart';
import 'package:restofulist/ui/components/platform_widget.dart';
import 'package:restofulist/ui/components/restaurant_detail_menus.dart';
import 'package:restofulist/ui/screens/restaurant_add_review.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  const RestaurantDetailPage({Key? key}) : super(key: key);

  Widget _buildAppBar(BuildContext context, Restaurant restaurant) {
    return Column(
      children: [
        const SizedBox(height: 5),
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
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildContent(BuildContext context, Restaurant restaurant) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Hero(
              tag: restaurant.id,
              child: Image.network(
                  ApiService.getPictureUrl(restaurant.pictureId))),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 5,
                  children: restaurant.categories
                      .map((e) => Chip(
                            label: Text(e.name),
                            backgroundColor: Colors.amber,
                          ))
                      .toList(),
                ),
                const Divider(color: Colors.grey),
                Text(
                  restaurant.description,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.grey),
                RestaurantDetailMenusView(restaurant: restaurant),
                const SizedBox(height: 10),
                const Divider(color: Colors.grey),
                const SizedBox(height: 10),
                Text(
                  'Customer Review (${restaurant.customerReviews.length})',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RestaurantAddReviewPage.routeName,
                        arguments: RestaurantAddReviewPageIntent(
                            restaurant,
                            () => {
                                  Provider.of<RestaurantDetailProvider>(context,
                                          listen: false)
                                      .fetch(restaurant.id)
                                }));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Review'),
                ),
                const SizedBox(height: 10),
                LimitedBox(
                  maxHeight: 400,
                  child: ListView.builder(
                    itemCount: restaurant.customerReviews.length,
                    itemBuilder: (context, index) {
                      final review = restaurant.customerReviews[index];
                      return ListTile(
                        title: Text(review.name),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(review.date),
                              const SizedBox(height: 3),
                              Text(review.review),
                            ]),
                        leading: const Icon(Icons.person),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildAndroid(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
        builder: (context, provider, child) {
      if (provider.state == ApiResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (provider.state == ApiResultState.hasData) {
        return Scaffold(
          appBar: AppBar(
            title: _buildAppBar(context, provider.result.restaurant),
          ),
          body: _buildContent(context, provider.result.restaurant),
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

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }
}
