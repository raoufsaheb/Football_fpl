import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget goalStat(int expandedTime, int? homeGoal, int? awayGoal) {
  // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(expandedTime * 1000);
  String formattedDateTime = DateFormat.Hm()
      .format(DateTime.fromMillisecondsSinceEpoch(expandedTime * 1000));
// Format the DateTime as desired

  Object home;
  Object away;
  var score = formattedDateTime;
  homeGoal == null ? home = formattedDateTime : home = homeGoal;
  awayGoal == null ? away = formattedDateTime : away = awayGoal;
  homeGoal == null && awayGoal == null ? score = formattedDateTime : score = "$home - $away";
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        Expanded(
          child: Center(
            child: Text(
              score,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 36.0,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
