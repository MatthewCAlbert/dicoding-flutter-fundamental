import 'package:flutter/material.dart';
import 'package:restofulist/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantReminderPreferences();
  }

  bool _isDailyRestaurantReminderActive = false;
  bool get isDailyRestaurantReminderActive => _isDailyRestaurantReminderActive;

  void _getDailyRestaurantReminderPreferences() async {
    _isDailyRestaurantReminderActive =
        await preferencesHelper.isDailyRestaurantReminderActive;
    notifyListeners();
  }

  void enableDailyRestaurantReminder(bool value) {
    preferencesHelper.setDailyRestaurantReminder(value);
    _getDailyRestaurantReminderPreferences();
  }
}
