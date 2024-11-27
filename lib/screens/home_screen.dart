import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:football/screens/TeamPage.dart';
import '../apis/api_football_fixture.dart';
import '../models/fixture.dart';
import '../widgets/date_bar.dart';
import '../widgets/matchtile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Fixture>> liveFixtures;
  int selectedRound = 1;
  int round = 1;
  @override
  void initState() {
    super.initState();
    setState(() {
      liveFixtures =
          FixtureApi().getLiveFixtures("fixtures?season=2024&league=39");
    });
  }

  void updateFixtures(int r) {
    setState(() {
      round = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      
      leading: const Icon(Icons.arrow_back_ios),
      title: const Text("Matches"),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
      headerWidget: headerWidget(context),
      headerBottomBar: headerBottomBarWidget(),
      expandedBody:  PlayerDataScreen(),
      body: [
        DateBar(
          liveFixtures: liveFixtures,
          onRoundSelected: updateFixtures,
        ),
        futureBuilderHome(round),
      ],
      fullyStretchable: true,
      // expandedBody: const CameraPreview(),
      backgroundColor: const Color.fromARGB(255, 2, 11, 11),
      appBarColor: Colors.teal,
    );
  }

  FutureBuilder<List<Fixture>> futureBuilderHome(int round) {
    return FutureBuilder<List<Fixture>>(
      future: liveFixtures,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.hasData) {
          final fixtures = snapshot.data!;

          return listView(fixtures, round);
        } else {
          return const Center(
            child: Text('No live fixtures available.'),
          );
        }
      },
    );
  }

  Row headerBottomBarWidget() {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 9, 108, 42),
      child: Center(
        child: Text(
          "Football FPL",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.white70),
        ),
      ),
    );
  }

  ListView listView(List<Fixture> allmatches, int round) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: allmatches.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return matchTile(allmatches[index], round, context);
        });
  }
}
