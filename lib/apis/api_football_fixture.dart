//before let's add the http package
import 'dart:convert';

import 'package:http/http.dart';

import '../models/fixture.dart';

class FixtureApi {
  // ... other methods and properties ...
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    //Always make sure to check the api key and the limit of a request in a free api
    'x-rapidapi-key': "e4671708893ec0a28bebdf6810e7c451"
  };
  Future<List<Fixture>> getLiveFixtures(String paramater) async {
    final response = await get(
      Uri.parse(
          'https://v3.football.api-sports.io/$paramater'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> fixturesList = body['response'];
      final List<Fixture> fixtures =
          fixturesList.map((dynamic item) => Fixture.fromJson(item)).toList();
      return fixtures;
    } else {
      throw "Can't get live fixtures.";
    }
  }
}
