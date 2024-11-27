class LeagueData {
  int id;
  String joinedTime;
  int startedEvent;
  int favouriteTeam;
  String playerFirstName;
  String playerLastName;
  int playerRegionId;
  String playerRegionName;
  String playerRegionIsoCodeShort;
  String playerRegionIsoCodeLong;
  int summaryOverallPoints;
  int summaryOverallRank;
  int summaryEventPoints;
  int summaryEventRank;
  int currentEvent;
  Leagues leagues;
  String name;
  bool nameChangeBlocked;
  int lastDeadlineBank;
  int lastDeadlineValue;
  int lastDeadlineTotalTransfers;

  LeagueData({
    required this.id,
    required this.joinedTime,
    required this.startedEvent,
    required this.favouriteTeam,
    required this.playerFirstName,
    required this.playerLastName,
    required this.playerRegionId,
    required this.playerRegionName,
    required this.playerRegionIsoCodeShort,
    required this.playerRegionIsoCodeLong,
    required this.summaryOverallPoints,
    required this.summaryOverallRank,
    required this.summaryEventPoints,
    required this.summaryEventRank,
    required this.currentEvent,
    required this.leagues,
    required this.name,
    required this.nameChangeBlocked,
    required this.lastDeadlineBank,
    required this.lastDeadlineValue,
    required this.lastDeadlineTotalTransfers,
  });

  factory LeagueData.fromJson(Map<String, dynamic> json) {
    return LeagueData(
      id: json['id'],
      joinedTime: json['joined_time'],
      startedEvent: json['started_event'],
      favouriteTeam: json['favourite_team'],
      playerFirstName: json['player_first_name'],
      playerLastName: json['player_last_name'],
      playerRegionId: json['player_region_id'],
      playerRegionName: json['player_region_name'],
      playerRegionIsoCodeShort: json['player_region_iso_code_short'],
      playerRegionIsoCodeLong: json['player_region_iso_code_long'],
      summaryOverallPoints: json['summary_overall_points'],
      summaryOverallRank: json['summary_overall_rank'],
      summaryEventPoints: json['summary_event_points'],
      summaryEventRank: json['summary_event_rank'],
      currentEvent: json['current_event'],
      leagues: Leagues.fromJson(json['leagues']),
      name: json['name'],
      nameChangeBlocked: json['name_change_blocked'],
      lastDeadlineBank: json['last_deadline_bank'],
      lastDeadlineValue: json['last_deadline_value'],
      lastDeadlineTotalTransfers: json['last_deadline_total_transfers'],
    );
  }
}

class Leagues {
  List<Classic> classic;
  List<H2h> h2h;
  Cup cup;

  Leagues({
    required this.classic,
    required this.h2h,
    required this.cup,
  });

  factory Leagues.fromJson(Map<String, dynamic> json) {
    return Leagues(
      classic: List<Classic>.from(json['classic'].map((x) => Classic.fromJson(x))),
      h2h: List<H2h>.from(json['h2h'].map((x) => H2h.fromJson(x))),
      cup: Cup.fromJson(json['cup']),
    );
  }
}

class Classic {
  int id;
  String name;
  String? shortName;
  String created;
  bool closed;
  int? rank; // Could be nullable, modify as needed
  int? maxEntries; // Could be nullable, modify as needed
  String leagueType;
  String scoring;
  int? adminEntry; // Could be nullable, modify as needed
  int startEvent;
  bool entryCanLeave;
  bool entryCanAdmin;
  bool entryCanInvite;
  bool hasCup;
  dynamic cupLeague;
  dynamic cupQualified;
  int entryRank;
  int entryLastRank;

  Classic({
    required this.id,
    required this.name,
    required this.shortName,
    required this.created,
    required this.closed,
    required this.rank,
    required this.maxEntries,
    required this.leagueType,
    required this.scoring,
    required this.adminEntry,
    required this.startEvent,
    required this.entryCanLeave,
    required this.entryCanAdmin,
    required this.entryCanInvite,
    required this.hasCup,
    required this.cupLeague,
    required this.cupQualified,
    required this.entryRank,
    required this.entryLastRank,
  });

  factory Classic.fromJson(Map<String, dynamic> json) {
    return Classic(
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'],
      created: json['created'],
      closed: json['closed'],
      rank: json['rank'],
      maxEntries: json['max_entries'],
      leagueType: json['league_type'],
      scoring: json['scoring'],
      adminEntry: json['admin_entry'],
      startEvent: json['start_event'],
      entryCanLeave: json['entry_can_leave'],
      entryCanAdmin: json['entry_can_admin'],
      entryCanInvite: json['entry_can_invite'],
      hasCup: json['has_cup'],
      cupLeague: json['cup_league'],
      cupQualified: json['cup_qualified'],
      entryRank: json['entry_rank'],
      entryLastRank: json['entry_last_rank'],
    );
  }
}

class H2h {
  int id;
  String name;
  String? shortName; // Could be nullable, modify as needed
  String created;
  bool closed;
  int? rank; // Could be nullable, modify as needed
  int? maxEntries; // Could be nullable, modify as needed
  String leagueType;
  String scoring;
  int? adminEntry; // Could be nullable, modify as needed
  int startEvent;
  bool entryCanLeave;
  bool entryCanAdmin;
  bool entryCanInvite;
  bool hasCup;
  dynamic cupLeague;
  dynamic cupQualified;
  int entryRank;
  int entryLastRank;

  H2h({
    required this.id,
    required this.name,
    required this.shortName,
    required this.created,
    required this.closed,
    required this.rank,
    required this.maxEntries,
    required this.leagueType,
    required this.scoring,
    required this.adminEntry,
    required this.startEvent,
    required this.entryCanLeave,
    required this.entryCanAdmin,
    required this.entryCanInvite,
    required this.hasCup,
    required this.cupLeague,
    required this.cupQualified,
    required this.entryRank,
    required this.entryLastRank,
  });

  factory H2h.fromJson(Map<String, dynamic> json) {
    return H2h(
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'],
      created: json['created'],
      closed: json['closed'],
      rank: json['rank'],
      maxEntries: json['max_entries'],
      leagueType: json['league_type'],
      scoring: json['scoring'],
      adminEntry: json['admin_entry'],
      startEvent: json['start_event'],
      entryCanLeave: json['entry_can_leave'],
      entryCanAdmin: json['entry_can_admin'],
      entryCanInvite: json['entry_can_invite'],
      hasCup: json['has_cup'],
      cupLeague: json['cup_league'],
      cupQualified: json['cup_qualified'],
      entryRank: json['entry_rank'],
      entryLastRank: json['entry_last_rank'],
    );
  }
}

class Cup {
  List<dynamic> matches;
  CupStatus status;
  dynamic cupLeague;

  Cup({
    required this.matches,
    required this.status,
    required this.cupLeague,
  });

  factory Cup.fromJson(Map<String, dynamic> json) {
    return Cup(
      matches: json['matches'],
      status: CupStatus.fromJson(json['status']),
      cupLeague: json['cup_league'],
    );
  }
}

class CupStatus {
  dynamic qualificationEvent;
  dynamic qualificationNumbers;
  dynamic qualificationRank;
  dynamic qualificationState;

  CupStatus({
    required this.qualificationEvent,
    required this.qualificationNumbers,
    required this.qualificationRank,
    required this.qualificationState,
  });

  factory CupStatus.fromJson(Map<String, dynamic> json) {
    return CupStatus(
      qualificationEvent: json['qualification_event'],
      qualificationNumbers: json['qualification_numbers'],
      qualificationRank: json['qualification_rank'],
      qualificationState: json['qualification_state'],
    );
  }
}
