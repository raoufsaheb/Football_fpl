class Fixture {
  final int id;
  final DateTime date;
  final String status;
  final String homeTeam;
  final String awayTeam;
  final int? homeGoals;
  final int? awayGoals;
  final String homeLogoUrl;
  final String awayLogoUrl;
  final int timestamp;
  final String league;
  // final String elapsed;

  Fixture({
    required this.id,
    required this.date,
    required this.status,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeGoals,
    required this.awayGoals,
    required this.homeLogoUrl,
    required this.awayLogoUrl,
    required this.timestamp,
    required this.league,
    // required this.elapsed,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    final fixture = json['fixture'];
    final league = json['league'];
    final teams = json['teams'];
    final goals = json['goals'];

    return Fixture(
      id: fixture['id'],
      date: DateTime.parse(fixture['date']),
      status: fixture['status']['long'],
      homeTeam: teams['home']['name'],
      awayTeam: teams['away']['name'],
      homeGoals: goals['home'],
      awayGoals: goals['away'],
      homeLogoUrl: teams['home']['logo'],
      awayLogoUrl: teams['away']['logo'],
      timestamp: fixture['timestamp'],
      league: league['round'],
      // elapsed: fixture['satuts']['elapsed'],
    );
  }
}
