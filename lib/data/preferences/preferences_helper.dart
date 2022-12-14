import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyRestaurantReminder = 'DAILY_RESTAURANT_REMINDER';

  Future<bool> get isDailyRestaurantReminderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestaurantReminder) ?? false;
  }

  void setDailyRestaurantReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestaurantReminder, value);
  }
}
