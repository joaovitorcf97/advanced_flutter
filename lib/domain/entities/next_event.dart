import 'package:advanced_flutter/domain/entities/next_event_player.dart';

class NextEvent {
  final String groupName;
  final DateTime date;
  final List<NextEventPlayer> players;

  NextEvent(this.players, {required this.groupName, required this.date});
}
