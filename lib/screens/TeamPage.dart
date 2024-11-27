import 'package:flutter/material.dart';
import 'package:football/models/player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'leagues_secreen.dart';

class PlayerDataScreen extends StatefulWidget {
  @override
  _PlayerDataScreenState createState() => _PlayerDataScreenState();
}

class _PlayerDataScreenState extends State<PlayerDataScreen> {
  final TextEditingController _idController = TextEditingController();
  PlayerData? _playerData;
  late SharedPreferences _prefs;
  String _savedId = '';

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _savedId = _prefs.getString('saved_id') ?? '';
    setState(() {
      _idController.text = _savedId;
    });
  }

  Future<void> _fetchPlayerData() async {
    _prefs.setString('saved_id', _idController.text); // Save the entered ID
    final response = await http.get(
      Uri.parse(
          'https://fantasy.premierleague.com/api/entry/${_savedId}/history/'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _playerData = PlayerData.fromJson(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load player data');
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 22, 22),
      // appBar: AppBar(
      //   title: Text('Player Data'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ifNewUser(),
      ),
    );
  }

  Widget ifNewUser() {
    if (_savedId == '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: _idController,
              decoration: InputDecoration(labelText: 'Enter Player ID'),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _fetchPlayerData,
            child: Text('Search'),
          ),
          SizedBox(height: 20),
          // if (_playerData != null)
          //   Text('Total Points: ${_playerData!.current[1].totalPoints}'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How can i get my id :",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "1. Go to https://fantasy.premierleague.com/",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "2. Login to your account",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "3. Go to 'My Team'",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "4. Click on 'Points'",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "5. Copy the number in the url after 'entry/{your id is here}/history/'",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      );
    } else {
      _fetchPlayerData();
      if (_playerData == null) {
        return Center(
          child: Text('Loading...', style: TextStyle(color: Colors.white)),
        );
      } else {
        var i = _playerData!.current.length - 1;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(' ${_playerData!.current[i].points}',
                  style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w100,
                      color: const Color.fromARGB(255, 195, 255, 249))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                playerInfo(
                  "${_playerData!.current[i].totalPoints}",
                  "Total Points",
                ),
                playerInfo(
                  ' ${(_playerData!.current[i].bank / 10)} €',
                  "Your Bank",
                ),
                playerInfo(
                  ' ${(_playerData!.current[i].pointsOnBench)} ',
                  "Points on bench",
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            //i want grideview here
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              ),
              itemCount: 4, // Four items: League, My Team, Search, Settings
              shrinkWrap: true,
              itemBuilder: (context, index) {
                late String title;
                late IconData iconData;

                switch (index) {
                  case 0:
                    title = 'League';
                    iconData = Icons.sports_soccer;
                    break;
                  case 1:
                    title = 'My Team';
                    iconData = Icons.group;
                    break;
                  case 2:
                    title = 'Search';
                    iconData = Icons.search;
                    break;
                  case 3:
                    title = 'Settings';
                    iconData = Icons.settings;
                    break;
                  default:
                    title = '';
                    iconData = Icons.error;
                }

                return GestureDetector(
                  onTap: () {
                    // Handle the onTap event for each item
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => League(_savedId, _playerData),
                        ),
                      );
                      // Handle League item tap
                    } else if (index == 1) {
                      print(1);
                      // Handle My Team item tap
                    } else if (index == 2) {
                      print(2);
                      // Handle Search item tap
                    } else if (index == 3) {
                      print(3);
                      // Handle Settings item tap
                    }
                  },
                  child: Card(
                    color: Color.fromARGB(255, 43, 43, 43),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(iconData,
                            size: 48.0,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        SizedBox(height: 8.0),
                        Text(
                          title,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        );
      }
    }
  }

  Column playerInfo(String title, String subtitle) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w100,
                color: Color.fromARGB(255, 249, 255, 254))),
        Text('${subtitle}',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w100,
                color: Color.fromARGB(255, 231, 246, 244))),
      ],
    );
  }
}
