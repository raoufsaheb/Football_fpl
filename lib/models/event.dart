class Event {
  final Map<String, dynamic> time;
  final Map<String, dynamic> team;
  final Map<String, dynamic> player;
  final Map<String, dynamic> assist;
  final String type;
  final String detail;
  final String? comments;

  Event({
    required this.time,
    required this.team,
    required this.player,
    required this.assist,
    required this.type,
    required this.detail,
    required this.comments,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      time: json['time'] as Map<String, dynamic>,
      team: json['team'] as Map<String, dynamic>,
      player: json['player'] as Map<String, dynamic>,
      assist: json['assist'] as Map<String, dynamic>,
      type: json['type'] as String,
      detail: json['detail'] as String,
      comments: json['comments'] as String?,
    );
  }
}
