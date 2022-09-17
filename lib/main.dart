import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restofulist/common/styles.dart';
import 'package:restofulist/data/api/api_service.dart';
import 'package:restofulist/provider/restaurant_provider.dart';
import 'package:restofulist/ui/screens/restaurant_detail_page.dart';
import 'package:restofulist/ui/screens/restaurant_list_page.dart';
import 'package:restofulist/ui/screens/restaurant_search_page.dart';
import 'package:restofulist/utils/background_service.dart';
import 'package:restofulist/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restofulist',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(elevation: 0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
      ),
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => ChangeNotifierProvider(
              create: (_) => RestaurantListProvider(apiService: ApiService()),
              child: const RestaurantListPage(),
            ),
        RestaurantSearchPage.routeName: (context) => ChangeNotifierProvider(
              create: (_) => RestaurantSearchProvider(apiService: ApiService()),
              child: const RestaurantSearchPage(),
            ),
        RestaurantDetailPage.routeName: (context) => ChangeNotifierProvider(
              create: (_) => RestaurantDetailProvider(
                  apiService: ApiService(),
                  id: ModalRoute.of(context)?.settings.arguments as String),
              child: const RestaurantDetailPage(),
            ),
      },
    );
  }
}
