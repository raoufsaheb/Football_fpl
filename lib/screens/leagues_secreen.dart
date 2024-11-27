import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football/models/player.dart';
import 'package:football/screens/League_standing_screen.dart';
import 'package:http/http.dart' as http;
import '../models/leagues.dart';

class League extends StatefulWidget {
  final String savedId;
  final PlayerData? playerData;

  const League(this.savedId, this.playerData, {Key? key}) : super(key: key);

  @override
  State<League> createState() => _LeagueState();
}

class _LeagueState extends State<League> {
  LeagueData? leagueData = null;

  @override
  void initState() {
    super.initState();
    _fetchPlayerData(widget.savedId);
  }

  Future<void> _fetchPlayerData(String savedId) async {
    final response = await http.get(
      Uri.parse('https://fantasy.premierleague.com/api/entry/$savedId'),
    );

    if (response.statusCode == 200) {
      final responseBody =
          utf8.decode(response.bodyBytes); // Ensure UTF-8 decoding
      setState(() {
        leagueData = LeagueData.fromJson(json.decode(responseBody));
        // Save the entered ID
        print(leagueData!.leagues.classic[8].name);
      });
    } else {
      throw Exception('Failed to load player data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leagues"),
      ),
      body: listOfLeague(),
    );
  }

  Widget listOfLeague() {
    if (leagueData != null) {
      return ListView.builder(
        itemCount: leagueData!.leagues.classic.length,
        itemBuilder: (BuildContext context, int index) {
          // print("${leagueData!.leagues!.classic[index].name}");
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LeagueStandingPage(
                    leagueData!.leagues.classic[index].id, leagueData),
              ),
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${leagueData!.leagues.classic[index].name}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "${leagueData!.leagues.classic[index].entryRank}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text("loading .. "),
      );
    }
  }
}
// Text(leagueData?.leagues?.classic[1].name ?? "Loading..."),