import 'package:flutter/material.dart';
import 'package:football/models/fixture.dart';
import 'package:intl/intl.dart';

Widget liveDetail(Fixture match) {
  String formattedDateTime = DateFormat.Hm()
      .format(DateTime.fromMillisecondsSinceEpoch(match.timestamp * 1000));
  var sccore = match.homeGoals == null && match.awayGoals == null
      ? formattedDateTime
      : "${match.homeGoals} - ${match.awayGoals}";
  var date = match.homeGoals != null || match.awayGoals != null
      ? ""
      : "${match.date.day}/${match.date.month}";
  return Row(
    children: [
      const SizedBox(height: 360.0),
      Expanded(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.network(
                        match.homeLogoUrl,
                        height: 85.0,
                        width: 85.0,
                      ),
                      Text(
                        match.homeTeam,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        date,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        sccore,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                        ),
                      ),
                      const Text(
                        "HT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.network(
                        match.awayLogoUrl,
                        height: 85.0,
                        width: 85.0,
                      ),
                      Text(
                        match.awayTeam,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}
