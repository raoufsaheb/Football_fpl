import 'package:flutter/material.dart';
Widget teamstate(String team, String logoUrl, String teamName) {
  return Expanded(
    child: Column(
      children: [
        Text(
          team,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Image.network(
            logoUrl,
            width: 54.0,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          teamName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    ),
  );
    
}