import 'package:flutter/material.dart';
import 'package:restofulist/common/styles.dart';
import 'package:restofulist/data/model/restaurant.dart';
import 'package:restofulist/ui/components/dashed_separator.dart';
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
  List<RestaurantMenuItem> _shownMenus = [];

  void _onTypeClicked(int index) {
    setState(() {
      _menuIndex = index;
    });
  }

  Widget _buildMenuItem(BuildContext context, RestaurantMenuItem item) {
    return Column(
      children: [
        const SizedBox(height: 17),
        Text(
          item.name,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 17),
        CustomPaint(painter: DrawDottedHorizontalLine()),
      ],
    );
  }

  Widget _buildMenus(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: CustomPaint(
                  painter: DrawDottedHorizontalLine(),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in _shownMenus)
                      _buildMenuItem(context, item),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, int index) {
    // bordered button
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        backgroundColor: _menuIndex == index
            ? primaryColor
            : Theme.of(context).colorScheme.surface,
      ),
      child: InkWell(
        onTap: () => _onTypeClicked(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Text(
            '$label (${index == 0 ? widget.restaurant.menus.foods.length : widget.restaurant.menus.drinks.length})',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _menuIndex == index
                      ? primaryRed
                      : const Color(0xff707070),
                ),
          ),
        ),
      ),
      onPressed: () => _onTypeClicked(index),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          'Menu',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildMenuButton(context, 'Foods', 0),
            const SizedBox(width: 10),
            _buildMenuButton(context, 'Drinks', 1),
          ],
        ),
        const SizedBox(height: 15),
        _buildMenus(context),
        const SizedBox(height: 40),
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
    setState(() {
      _shownMenus = _menuIndex == 0
          ? widget.restaurant.menus.foods
          : widget.restaurant.menus.drinks;
    });

    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
