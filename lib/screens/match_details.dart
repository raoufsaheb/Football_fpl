import 'package:flutter/material.dart';
import 'package:football/models/event.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:football/widgets/live_detail.dart';
import '../models/fixture.dart';
import '../apis/api_football_events.dart';
import 'package:appbar_animated/appbar_animated.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';

class MatchDetailsScreen extends StatefulWidget {
  final Fixture match;

  const MatchDetailsScreen({Key? key, required this.match}) : super(key: key);

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  late Future<List<Event>> liveEvents;
  late Future<List<Event>> liveEventsall;
  // late AwesomeNotifications _awesomeNotifications;

  @override
  void initState() {
    super.initState();

    var fixId = widget.match.id;
    print(fixId);
    setState(() {
      liveEvents =
          EventsApi().getLiveEvents("fixtures/events?fixture=$fixId&type=goal");
      liveEventsall =
          EventsApi().getLiveEvents("fixtures/events?fixture=$fixId");
    });
    // _awesomeNotifications = AwesomeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: ScaffoldLayoutBuilder(
        backgroundColorAppBar:
            const ColorBuilder(Colors.transparent, Colors.teal),
        textColorAppBar: const ColorBuilder(Colors.white),
        appBarBuilder: _appBar,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                "images/football.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
              //  goalStat(match.timestamp, match.homeGoals, match.awayGoals),
              liveDetail(widget.match),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.36,
                ),
                // height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  color: Color.fromARGB(255, 20, 20, 20),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text("GOLS!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            )),
                        timeLineBulder(liveEvents),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Events",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            )),
                        timeLineBulder(liveEventsall),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      //     bottomNavigationBar: AnimatedNotchBottomBar(
      //       onTap: (value) => print(value),
      //       notchBottomBarController: NotchBottomBarController(),
      //       bottomBarItems: [
      //   const BottomBarItem(
      //       inActiveItem: Icon(
      //          Icons.home_filled,
      //           color: Colors.blueGrey,
      //       ),
      //       activeItem: Icon(
      //         Icons.home_filled,
      //         color: Colors.blueAccent,
      //       ),
      //       itemLabel: 'Page 1',
      // ),
      //   const BottomBarItem(
      //       inActiveItem: Icon(
      //           Icons.star,
      //           color: Colors.blueGrey,
      //         ),
      //       activeItem: Icon(
      //           Icons.star,
      //           color: Colors.blueAccent,
      //       ),
      //       itemLabel: 'Page 2',
      // ),

      //    ///svg item
      //   ],
      //     ),
    );
  }

  FutureBuilder<List<Event>> timeLineBulder(Future<List<Event>> e) {
    return FutureBuilder<List<Event>>(
      future: e,
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

          return listView(fixtures);
        } else {
          return const Center(
            child: Text('No live fixtures available.'),
          );
        }
      },
    );
  }

  ListView listView(List<Event> allEvents) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: allEvents.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return timeLine(allEvents[index], context);
        });
  }

  TimelineTile timeLine(Event event, BuildContext context) {
    print(event.detail);

    var Home = event.team['name'] == widget.match.homeTeam ? true : false;
    var Away = event.team['name'] == widget.match.awayTeam ? true : false;
    Color colorHome = Home == true ? Colors.white : Colors.transparent;
    Color colorAway = Away == true ? Colors.white : Colors.transparent;
    Color secondHome = colorHome;
    Color secondAway = colorAway;
    var player = "";
    var subtitle = "";
    Icon icon = const Icon(Icons.sports_soccer);
    if (event.type == "Goal") {
      player = event.player['name'];
      subtitle = event.assist['name'] ?? "no assiste";
      icon = const Icon(Icons.sports_soccer);
      if (event.detail == "Own Goal") {
        colorHome = Home == true
            ? const Color.fromARGB(255, 197, 76, 76)
            : Colors.transparent;
        colorAway = Away == true
            ? const Color.fromARGB(255, 197, 76, 76)
            : Colors.transparent;
        subtitle = "Own Goal";
      } else if (event.detail == "Penalty") {
        // icon = Icon(MdiIcons.whistle);
        subtitle = "Penalty";
      } else if (event.detail == "Missed Penalty") {
        icon = Icon(MdiIcons.whistle);
        subtitle = "Penalty Missed";
        colorHome = Home == true
            ? const Color.fromARGB(255, 197, 76, 76)
            : Colors.transparent;
        colorAway = Away == true
            ? const Color.fromARGB(255, 197, 76, 76)
            : Colors.transparent;
      }
    }

    if (event.type == "Card") {
      if (event.detail == "Yellow Card") {
        player = event.player['name'];
        subtitle = event.detail;
        colorHome = Home == true ? Colors.yellow : Colors.transparent;
        colorAway = Away == true ? Colors.yellow : Colors.transparent;
        secondHome = colorHome;
        secondAway = colorAway;
        // i want icon like yellow card
        icon = const Icon(Icons.rectangle);
      } else {
        player = event.player['name'];
        subtitle = event.detail;
        colorHome = Home == true
            ? const Color.fromARGB(255, 197, 76, 76)
            : Colors.transparent;
        colorAway = Away == true
            ? const Color.fromARGB(255, 197, 76, 76)
            : Colors.transparent;
        secondHome = colorHome;
        secondAway = colorAway;
        // i want icon like yellow card
        icon = const Icon(Icons.rectangle);
      }
    }

    if (event.type == "subst") {
      player = event.assist['name'];
      subtitle = event.player['name'];
      colorHome = Home == true ? Colors.green : Colors.transparent;
      colorAway = Away == true ? Colors.green : Colors.transparent;
      secondHome = Home == true
          ? const Color.fromARGB(255, 175, 76, 76)
          : Colors.transparent;
      secondAway = Away == true
          ? const Color.fromARGB(255, 175, 76, 76)
          : Colors.transparent;

      // i want icon subst
      icon = const Icon(Icons.subdirectory_arrow_right);
    }

    if (event.type == "Var") {
      icon = Icon(MdiIcons.whistle);
      if (event.detail == "Penalty confirmed") {
        player = event.detail;
        subtitle = "VAR";
      } else if (event.detail == "Goal cancelled") {
        player = event.player['name'];
        subtitle = "${event.detail} (VAR)";
      } else if (event.detail == "Goal confirmed") {
        player = event.player['name'];
        subtitle = "${event.detail} (VAR)";
      }
    }
    return TimelineTile(
      indicatorStyle: IndicatorStyle(
        indicator: Center(
          child: Text("${event.time['elapsed']}'",
              style: const TextStyle(color: Colors.teal)),
        ),
        width: 20,
        color: Colors.teal,
        padding: const EdgeInsets.all(8),
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: Icons.sports_soccer,
        ),
      ),
      beforeLineStyle: const LineStyle(color: Colors.white, thickness: 1),
      alignment: TimelineAlign.center,
      startChild: matchEvents(player, subtitle, colorHome, secondHome, icon),
      endChild: matchEvents(player, subtitle, colorAway, secondAway, icon),
    );
  }

  Container matchEvents(player, String sub, firstcolor, secondcolor, icon) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon.icon, color: firstcolor, size: 20.0),
            ),
            Column(
              children: [
                Text(
                  "$player",
                  style: TextStyle(
                    color: firstcolor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  sub,
                  style: TextStyle(
                    color: secondcolor,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
    return AppBar(
      backgroundColor: colorAnimated.background,
      elevation: 0,
      title: Text(
        "AppBar Animate",
        style: TextStyle(
          color: colorAnimated.color,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: colorAnimated.color,
        ),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: Icon(
      //       Icons.favorite,
      //       color: colorAnimated.color,
      //     ),
      //   ),
      // ],
    );
  }
}
