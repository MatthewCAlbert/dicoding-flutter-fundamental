import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:restofulist/data/db/database_helper.dart';
import 'package:restofulist/data/model/api/restaurant_list.dart';
import 'package:restofulist/provider/database_provider.dart';
import 'package:restofulist/ui/components/restaurant_favorite_button.dart';

import 'favorite_button_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  final restaurant = RestaurantShortVersion(
    id: 'rqdv5juczeskfw1e867',
    name: 'Melting Pot',
    description: '',
    pictureId: '14',
    city: 'Medan',
    rating: 4.2,
  );
  MockDatabaseHelper databaseHelper = MockDatabaseHelper();

  Widget createFavoriteButton() => ChangeNotifierProvider<DatabaseProvider>(
        create: (context) => DatabaseProvider(databaseHelper: databaseHelper),
        child: MaterialApp(
          home:
              Material(child: RestaurantFavoriteButton(restaurant: restaurant)),
        ),
      );

  group('Favorite Button Widget Test', () {
    testWidgets('Testing if button shown as not favorited',
        (WidgetTester tester) async {
      when(databaseHelper.getFavorites()).thenAnswer((_) async {
        return [];
      });
      await tester.pumpWidget(createFavoriteButton());
      expect((tester.firstWidget(find.byType(IconButton)) as IconButton).color,
          Colors.grey);
    });
    testWidgets('Testing if button shown as favorited',
        (WidgetTester tester) async {
      when(databaseHelper.getFavorites()).thenAnswer((_) async {
        return [
          restaurant,
        ].toList();
      });
      await tester.pumpWidget(createFavoriteButton());
      await tester.pumpAndSettle();
      expect((tester.firstWidget(find.byType(IconButton)) as IconButton).color,
          Colors.red);
    });
  });
}
