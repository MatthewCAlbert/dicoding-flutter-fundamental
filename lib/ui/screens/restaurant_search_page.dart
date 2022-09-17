import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restofulist/provider/restaurant_provider.dart';
import 'package:restofulist/ui/components/platform_widget.dart';
import 'package:restofulist/ui/components/restaurant_search_result.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurants-search';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final TextEditingController _searchQueryController = TextEditingController();

  String _query = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchQueryController.dispose();
    super.dispose();
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Search',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            'anything you like',
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
                    onChanged: (value) {
                      setState(() {
                        _query = value;
                      });
                      Provider.of<RestaurantSearchProvider>(context,
                              listen: false)
                          .fetch(value);
                    },
                    controller: _searchQueryController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Find restaurant...'),
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _query.isEmpty
                ? Center(
                    child: Text(
                      'Type something to search',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  )
                : const RestaurantSearchResult(),
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
