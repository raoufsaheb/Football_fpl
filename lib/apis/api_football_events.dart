//before let's add the http package
import 'dart:convert';

import 'package:http/http.dart';

import '../models/event.dart';

class EventsApi {
  // ... other methods and properties ...
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    //Always make sure to check the api key and the limit of a request in a free api
    //'x-rapidapi-key': "e4671708893ec0a28bebdf6810e7c451"
    'x-rapidapi-key': "e4671708893ec0a28bebdf6810e7c451"
  };
  Future<List<Event>> getLiveEvents(String paramater) async {
    final response = await get(
      Uri.parse('https://v3.football.api-sports.io/$paramater'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final List<dynamic> eventsList = body['response'];
      final List<Event> events =
          eventsList.map((dynamic item) => Event.fromJson(item)).toList();
      return events;
    } else {
      throw "Can't get live Events.";
    }
  }
}
