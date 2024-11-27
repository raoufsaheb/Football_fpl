class PlayerData {
  List<CurrentEvent> current;
  List<PastSeason> past;
  List<dynamic> chips; // Since "chips" is an empty list in the provided JSON

  PlayerData({
    required this.current,
    required this.past,
    required this.chips,
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      current: (json['current'] as List<dynamic>)
          .map((item) => CurrentEvent.fromJson(item))
          .toList(),
      past: (json['past'] as List<dynamic>)
          .map((item) => PastSeason.fromJson(item))
          .toList(),
      chips: json['chips'],
    );
  }
}

class CurrentEvent {
  int event;
  int points;
  int totalPoints;
  int? rank;
  int? rankSort;
  int? overallRank;
  int bank;
  int value;
  int eventTransfers;
  int eventTransfersCost;
  int pointsOnBench;

  CurrentEvent({
    required this.event,
    required this.points,
    required this.totalPoints,
    required this.rank,
    required this.rankSort,
    required this.overallRank,
    required this.bank,
    required this.value,
    required this.eventTransfers,
    required this.eventTransfersCost,
    required this.pointsOnBench,
  });

  factory CurrentEvent.fromJson(Map<String, dynamic> json) {
    return CurrentEvent(
      event: json['event'],
      points: json['points'],
      totalPoints: json['total_points'],
      rank: json['rank'],
      rankSort: json['rank_sort'],
      overallRank: json['overall_rank'],
      bank: json['bank'],
      value: json['value'],
      eventTransfers: json['event_transfers'],
      eventTransfersCost: json['event_transfers_cost'],
      pointsOnBench: json['points_on_bench'],
    );
  }
}

class PastSeason {
  String seasonName;
  int totalPoints;
  int rank;

  PastSeason({
    required this.seasonName,
    required this.totalPoints,
    required this.rank,
  });

  factory PastSeason.fromJson(Map<String, dynamic> json) {
    return PastSeason(
      seasonName: json['season_name'],
      totalPoints: json['total_points'],
      rank: json['rank'],
    );
  }
}
