import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/fixture.dart';
import '../screens/match_details.dart';

Widget matchTile(Fixture match, int round, BuildContext context) {
  // if (match.league == "Regular Season - 1") {
  if (match.league == "Regular Season - $round") {
    return match_tile(match, context);
  } else if (match.league != round) {
    return Container();
  } else {
    return match_tile(match, context);
  }
}

InkWell match_tile(Fixture match, BuildContext context) {
  var homeGoal = match.homeGoals;
  var awayGoal = match.awayGoals;
  Object home;
  Object away;
  String formattedDateTime = DateFormat.Hm()
      .format(DateTime.fromMillisecondsSinceEpoch(match.timestamp * 1000));
  // Format the DateTime as desired
  
  var score = formattedDateTime;
  homeGoal == null ? home = formattedDateTime : home = homeGoal;
  awayGoal == null ? away = formattedDateTime : away = awayGoal;
  homeGoal == null && awayGoal == null
      ? score = formattedDateTime
      : score = "$home - $away";
  
  return InkWell(
    onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDetailsScreen(match: match),
      ),
    );
  },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Text(
            "${match.date.day}/${match.date.month}/${match.date.year}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  match.homeTeam,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Image.network(
                match.homeLogoUrl,
                width: 36.0,
              ),
              Expanded(
                child: Text(
                  score,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Image.network(
                match.awayLogoUrl,
                width: 36.0,
              ),
              Expanded(
                child: Text(
                  match.awayTeam,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
