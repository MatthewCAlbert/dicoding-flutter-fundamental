import 'package:flutter_test/flutter_test.dart';
import 'package:restofulist/data/model/restaurant.dart';

void main() {
  group('Restaurant Parser', () {
    test('should able to parse RestaurantMenuItem from raw json', () {
      var stringJson = '''{"name":"Sirup"}''';
      var result = RestaurantMenuItem.fromRawJson(stringJson);
      expect(result.name, 'Sirup');
    });
    test('should able to parse RestaurantMenuItem from json', () {
      var json = {"name": "Sirup"};
      var result = RestaurantMenuItem.fromJson(json);
      expect(result.name, 'Sirup');
    });
    test('should able to parse RestaurantMenuItem to json', () {
      var json = {"name": "Sirup"};
      var result = RestaurantMenuItem.fromJson(json).toJson();
      expect(result, json);
      expect(result["name"], 'Sirup');
    });

    test('should able to parse Category from raw json', () {
      var stringJson = '''{"name":"Italia"}''';
      var result = Category.fromRawJson(stringJson);
      expect(result.name, 'Italia');
    });
    test('should able to parse Category from json', () {
      var json = {"name": "Italia"};
      var result = Category.fromJson(json);
      expect(result.name, 'Italia');
    });
    test('should able to parse Category to json', () {
      var json = {"name": "Italia"};
      var result = Category.fromJson(json).toJson();
      expect(result, json);
      expect(result['name'], 'Italia');
    });

    test('should able to parse CustomerReview from raw json', () {
      var stringJson =
          '''{"name":"Ahmad","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"}''';
      var result = CustomerReview.fromRawJson(stringJson);
      expect(result.name, 'Ahmad');
      expect(result.review, 'Tidak rekomendasi untuk pelajar!');
      expect(result.date, '13 November 2019');
    });
    test('should able to parse CustomerReview from json', () {
      var json = {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      };
      var result = CustomerReview.fromJson(json);
      expect(result.name, 'Ahmad');
      expect(result.review, 'Tidak rekomendasi untuk pelajar!');
      expect(result.date, '13 November 2019');
    });
    test('should able to parse CustomerReview to json', () {
      var json = {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      };
      var result = CustomerReview.fromJson(json).toJson();
      expect(result, json);
      expect(result['name'], 'Ahmad');
      expect(result['review'], 'Tidak rekomendasi untuk pelajar!');
      expect(result['date'], '13 November 2019');
    });

    test('should able to parse Menus from raw json', () {
      var json =
          '''{"foods":[{"name":"Paket rosemary"},{"name":"Toastie salmon"},{"name":"Bebek crepes"},{"name":"Salad lengkeng"}],"drinks":[{"name":"Es krim"},{"name":"Sirup"},{"name":"Jus apel"},{"name":"Jus jeruk"},{"name":"Coklat panas"},{"name":"Air"},{"name":"Es kopi"},{"name":"Jus alpukat"},{"name":"Jus mangga"},{"name":"Teh manis"},{"name":"Kopi espresso"},{"name":"Minuman soda"},{"name":"Jus tomat"}]}''';
      var result = Menus.fromRawJson(json);
      expect(result.foods.length, 4);
      expect(result.drinks.length, 13);
    });
    test('should able to parse Menus from json', () {
      var json = {
        "foods": [
          {"name": "Paket rosemary"},
          {"name": "Toastie salmon"},
          {"name": "Bebek crepes"},
          {"name": "Salad lengkeng"}
        ],
        "drinks": [
          {"name": "Es krim"},
          {"name": "Sirup"},
          {"name": "Jus apel"},
          {"name": "Jus jeruk"},
          {"name": "Coklat panas"},
          {"name": "Air"},
          {"name": "Es kopi"},
          {"name": "Jus alpukat"},
          {"name": "Jus mangga"},
          {"name": "Teh manis"},
          {"name": "Kopi espresso"},
          {"name": "Minuman soda"},
          {"name": "Jus tomat"}
        ]
      };
      var result = Menus.fromJson(json);
      expect(result.foods.length, 4);
      expect(result.drinks.length, 13);
    });
    test('should able to parse Menus to json', () {
      var json = {
        "foods": [
          {"name": "Paket rosemary"},
          {"name": "Toastie salmon"},
          {"name": "Bebek crepes"},
          {"name": "Salad lengkeng"}
        ],
        "drinks": [
          {"name": "Es krim"},
          {"name": "Sirup"},
          {"name": "Jus apel"},
          {"name": "Jus jeruk"},
          {"name": "Coklat panas"},
          {"name": "Air"},
          {"name": "Es kopi"},
          {"name": "Jus alpukat"},
          {"name": "Jus mangga"},
          {"name": "Teh manis"},
          {"name": "Kopi espresso"},
          {"name": "Minuman soda"},
          {"name": "Jus tomat"}
        ]
      };
      var result = Menus.fromJson(json).toJson();
      expect(result, json);
      expect(result['foods'].length, 4);
      expect(result['drinks'].length, 13);
    });

    test('should able to parse Restaurant from raw json', () {
      var stringJson =
          '''{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.","city":"Medan","address":"Jln. Pandeglang no 19","pictureId":"14","rating":4.2,"categories":[{"name":"Italia"},{"name":"Modern"}],"menus":{"foods":[{"name":"Paket rosemary"},{"name":"Toastie salmon"},{"name":"Bebek crepes"},{"name":"Salad lengkeng"}],"drinks":[{"name":"Es krim"},{"name":"Sirup"},{"name":"Jus apel"},{"name":"Jus jeruk"},{"name":"Coklat panas"},{"name":"Air"},{"name":"Es kopi"},{"name":"Jus alpukat"},{"name":"Jus mangga"},{"name":"Teh manis"},{"name":"Kopi espresso"},{"name":"Minuman soda"},{"name":"Jus tomat"}]},"customerReviews":[{"name":"Ahmad","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"},{"name":"Anonims.","review":"s","date":"25 September 2022"},{"name":"aaaaaaaaa saaaaaaaaaaaaaaaaaaaaaaaaaaaaa","review":"ssssssssssssssssssssssssssssssssssssssssssssssssssssssssss","date":"25 September 2022"}]}
        ''';
      var restaurant = Restaurant.fromRawJson(stringJson);
      expect(restaurant.id, 'rqdv5juczeskfw1e867');
      expect(restaurant.name, 'Melting Pot');
      expect(restaurant.city, 'Medan');
      expect(restaurant.address, 'Jln. Pandeglang no 19');
      expect(restaurant.pictureId, '14');
      expect(restaurant.rating, 4.2);
      expect(restaurant.menus.foods.length, 4);
      expect(restaurant.menus.drinks.length, 13);
    });
    test('should able to parse Restaurant from json', () {
      var json = {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "rating": 4.2,
        "categories": [
          {"name": "Italia"},
          {"name": "Modern"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"},
            {"name": "Toastie salmon"},
            {"name": "Bebek crepes"},
            {"name": "Salad lengkeng"}
          ],
          "drinks": [
            {"name": "Es krim"},
            {"name": "Sirup"},
            {"name": "Jus apel"},
            {"name": "Jus jeruk"},
            {"name": "Coklat panas"},
            {"name": "Air"},
            {"name": "Es kopi"},
            {"name": "Jus alpukat"},
            {"name": "Jus mangga"},
            {"name": "Teh manis"},
            {"name": "Kopi espresso"},
            {"name": "Minuman soda"},
            {"name": "Jus tomat"}
          ]
        },
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          },
          {"name": "Anonims.", "review": "s", "date": "25 September 2022"},
          {
            "name": "aaaaaaaaa saaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            "review":
                "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
            "date": "25 September 2022"
          }
        ]
      };
      var restaurant = Restaurant.fromJson(json);
      expect(restaurant.id, 'rqdv5juczeskfw1e867');
      expect(restaurant.name, 'Melting Pot');
      expect(restaurant.city, 'Medan');
      expect(restaurant.address, 'Jln. Pandeglang no 19');
      expect(restaurant.pictureId, '14');
      expect(restaurant.rating, 4.2);
      expect(restaurant.menus.foods.length, 4);
      expect(restaurant.menus.drinks.length, 13);
    });
    test('should able to parse Restaurant to json', () {
      var json = {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "rating": 4.2,
        "categories": [
          {"name": "Italia"},
          {"name": "Modern"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"},
            {"name": "Toastie salmon"},
            {"name": "Bebek crepes"},
            {"name": "Salad lengkeng"}
          ],
          "drinks": [
            {"name": "Es krim"},
            {"name": "Sirup"},
            {"name": "Jus apel"},
            {"name": "Jus jeruk"},
            {"name": "Coklat panas"},
            {"name": "Air"},
            {"name": "Es kopi"},
            {"name": "Jus alpukat"},
            {"name": "Jus mangga"},
            {"name": "Teh manis"},
            {"name": "Kopi espresso"},
            {"name": "Minuman soda"},
            {"name": "Jus tomat"}
          ]
        },
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          },
          {"name": "Anonims.", "review": "s", "date": "25 September 2022"},
          {
            "name": "aaaaaaaaa saaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            "review":
                "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
            "date": "25 September 2022"
          }
        ]
      };
      var restaurant = Restaurant.fromJson(json).toJson();
      expect(restaurant, json);
    });
  });
}
