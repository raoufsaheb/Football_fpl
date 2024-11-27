import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/player.dart';

Future<PlayerData> fetchPlayerData() async {
  final response = await http.get(
    Uri.parse('https://fantasy.premierleague.com/api/entry/181501/history/'),
  );

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return PlayerData.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load player data');
  }
}
