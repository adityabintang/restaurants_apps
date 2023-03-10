import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:restaurants_apps/data/api/api.dart';
import 'package:restaurants_apps/data/model/restaurantresults.dart';

void main() {
  group(
    'Testing Restaurant Api',
    () {
      test('if http call complete success return list of restaurant', () async {
        final client = MockClient((request) async {
          final response = {
            "error": false,
            "message": "success",
            "count": 20,
            "restaurants": []
          };
          return Response(json.encode(response), 200);
        });
        expect(
          await Api().fetchList(client),
          isA<RestaurantResult>(),
        );
      });
    },
  );
}
