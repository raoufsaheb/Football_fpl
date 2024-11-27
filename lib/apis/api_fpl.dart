import 'dart:async';
import 'package:http/http.dart' as http;

class Api {
  static Future<String> getTeam(String fplId) async {
    var url = 'https://fantasy.premierleague.com/api/my-team/$fplId';
    var response = await http.get(url as Uri);
    return response.body;
  }
}