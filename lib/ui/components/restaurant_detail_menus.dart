import 'package:flutter/material.dart';
import 'package:restofulist/common/styles.dart';
import 'package:restofulist/data/model/restaurant.dart';
import 'package:restofulist/ui/components/platform_widget.dart';

class RestaurantDetailMenusView extends StatefulWidget {
  const RestaurantDetailMenusView({Key? key, required this.restaurant})
      : super(key: key);
  final Restaurant restaurant;

  @override
  State<RestaurantDetailMenusView> createState() =>
      _RestaurantDetailMenusViewState();
}

class _RestaurantDetailMenusViewState extends State<RestaurantDetailMenusView> {
  int _menuIndex = 0;

  void _onTypeClicked(int index) {
    setState(() {
      _menuIndex = index;
    });
  }

  Widget _buildMenuItem(BuildContext context, int index) {
    return Material(
      color: _menuIndex == index ? Colors.white : Colors.transparent,
      child: InkWell(
        onTap: () => _onTypeClicked(index),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Menu $index',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _menuIndex == index ? primaryColor : Colors.black,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenus(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildMenuItem(context, index);
      },
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, int index) {
    return Material(
      color: _menuIndex == index ? primaryColor : Colors.transparent,
      child: InkWell(
        onTap: () => _onTypeClicked(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Menu $index',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _menuIndex == index ? Colors.white : Colors.black,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        Text(
          'Menu',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMenuButton(context, 'All', 0),
            _buildMenuButton(context, 'Breakfast', 1),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: _buildMenus(context),
        ),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return _buildMainContent(context);
  }

  Widget _buildIos(BuildContext context) {
    return _buildMainContent(context);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
