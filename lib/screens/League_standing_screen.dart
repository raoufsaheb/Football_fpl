import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football/models/leagues.dart';
import 'package:http/http.dart' as http;

import '../models/LeagueStandings .dart';

class LeagueStandingPage extends StatefulWidget {
  final int id;
  final LeagueData? leagueData;

  const LeagueStandingPage(this.id, this.leagueData, {Key? key})
      : super(key: key);

  @override
  State<LeagueStandingPage> createState() => _LeagueStandingPageState();
}

class _LeagueStandingPageState extends State<LeagueStandingPage> {
  LeagueStandings? leagueStandings = null;

  @override
  void initState() {
    super.initState();
    setState(() {
      _fetchPlayerData(widget.id);
    });
  }

  Future<void> _fetchPlayerData(int savedId) async {
    final response = await http.get(
      Uri.parse(
          'https://fantasy.premierleague.com/api/leagues-classic/$savedId/standings/'),
    );

    if (response.statusCode == 200) {
      final responseBody =
          utf8.decode(response.bodyBytes); // Ensure UTF-8 decoding
      setState(() {
        leagueStandings = LeagueStandings.fromJson(json.decode(responseBody));
        // Save the entered ID
        print(leagueStandings!.standings!.results.length);
      });
    } else {
      throw Exception('Failed to load player data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "${leagueStandings!.league!.name}",
              style: TextStyle(
                color: Colors.black,
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: listOfLeague(),
        ),
        backgroundColor: Colors.white);
  }

  Widget listOfLeague() {
    if (leagueStandings != null) {
      return ListView.builder(
        itemCount: leagueStandings!.standings!.results.length,
        itemBuilder: (BuildContext context, int index) {
          // print("${leagueData!.leagues!.classic[index].name}");
          return InkWell(
            onTap: () => print("object"),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${leagueStandings!.standings!.results[index].rank} - ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${leagueStandings!.standings!.results[index].entryName}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Text(
                      "${leagueStandings!.standings!.results[index].total}",
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
