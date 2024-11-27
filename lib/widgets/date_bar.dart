import 'package:flutter/material.dart';
import 'package:football/models/fixture.dart';


class DateBar extends StatefulWidget {
  final Future<List<Fixture>> liveFixtures;
  final Function(int round) onRoundSelected;

  const DateBar({Key? key, required this.liveFixtures, required this.onRoundSelected}) : super(key: key);

  @override
  _DateBarState createState() => _DateBarState();
}

class _DateBarState extends State<DateBar> {
  int selectedRound = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              // Handle "All" button press
            },
            child: const Text(
              "All",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          _buildRoundDropdown(),
          IconButton(
            onPressed: () {
              // Handle search button press
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundDropdown() {
    List<DropdownMenuItem<int>> roundItems = List.generate(38, (index) {
      int roundNumber = index + 1;
      return DropdownMenuItem<int>(
        value: roundNumber,
        child: Text(
          "Round $roundNumber",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      );
    });

    return SizedBox(
      width: 145, // Adjust the width to fit your design
      child: Center(
        child: DropdownButton<int>(
          value: selectedRound,
          onChanged: (int? newValue) {
            // Handle round selection
            setState(() {
              selectedRound = newValue!;
              widget.onRoundSelected(selectedRound);
            });
          },
          items: roundItems,
          dropdownColor:
              const Color.fromARGB(255, 8, 46, 17), // Set the background color of the dropdown list
        ),
      ),
    );
  }
}
