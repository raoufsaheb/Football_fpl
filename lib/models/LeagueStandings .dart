class LeagueStandings {
  NewEntries? newEntries;
  String? lastUpdatedData;
  League? league;
  Standings? standings;

  LeagueStandings({
    required this.newEntries,
    required this.lastUpdatedData,
    required this.league,
    required this.standings,
  });

  factory LeagueStandings.fromJson(Map<String, dynamic> json) {
    return LeagueStandings(
      newEntries: NewEntries.fromJson(json['new_entries']),
      lastUpdatedData: json['last_updated_data'],
      league: League.fromJson(json['league']),
      standings: Standings.fromJson(json['standings']),
    );
  }
}

class NewEntries {
  bool hasNext;
  int page;
  List<dynamic> results;

  NewEntries({
    required this.hasNext,
    required this.page,
    required this.results,
  });

  factory NewEntries.fromJson(Map<String, dynamic> json) {
    return NewEntries(
      hasNext: json['has_next'],
      page: json['page'],
      results: json['results'],
    );
  }
}

class League {
  int? id;
  String? name;
  String? created;
  bool? closed;
  int? maxEntries;
  String? leagueType;
  String? scoring;
  int? adminEntry;
  int? startEvent;
  String? codePrivacy;
  bool? hasCup;
  dynamic cupLeague;
  int? rank;

  League({
    required this.id,
    required this.name,
    required this.created,
    required this.closed,
    required this.maxEntries,
    required this.leagueType,
    required this.scoring,
    required this.adminEntry,
    required this.startEvent,
    required this.codePrivacy,
    required this.hasCup,
    required this.cupLeague,
    required this.rank,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      created: json['created'],
      closed: json['closed'],
      maxEntries: json['max_entries'],
      leagueType: json['league_type'],
      scoring: json['scoring'],
      adminEntry: json['admin_entry'],
      startEvent: json['start_event'],
      codePrivacy: json['code_privacy'],
      hasCup: json['has_cup'],
      cupLeague: json['cup_league'],
      rank: json['rank'],
    );
  }
}

class Standings {
  bool hasNext;
  int page;
  List<StandingResult> results;

  Standings({
    required this.hasNext,
    required this.page,
    required this.results,
  });

  factory Standings.fromJson(Map<String, dynamic> json) {
    return Standings(
      hasNext: json['has_next'],
      page: json['page'],
      results: List<StandingResult>.from(
          json['results'].map((x) => StandingResult.fromJson(x))),
    );
  }
}

class StandingResult {
  int id;
  int eventTotal;
  String playerName;
  int rank;
  int lastRank;
  int rankSort;
  int total;
  int entry;
  String entryName;

  StandingResult({
    required this.id,
    required this.eventTotal,
    required this.playerName,
    required this.rank,
    required this.lastRank,
    required this.rankSort,
    required this.total,
    required this.entry,
    required this.entryName,
  });

  factory StandingResult.fromJson(Map<String, dynamic> json) {
    return StandingResult(
      id: json['id'],
      eventTotal: json['event_total'],
      playerName: json['player_name'],
      rank: json['rank'],
      lastRank: json['last_rank'],
      rankSort: json['rank_sort'],
      total: json['total'],
      entry: json['entry'],
      entryName: json['entry_name'],
    );
  }
}
