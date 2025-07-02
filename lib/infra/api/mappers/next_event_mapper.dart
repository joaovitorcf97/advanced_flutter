import '../../../domain/entities/next_event.dart';
import '../../types/json.dart';
import 'next_event_player_mapper.dart';

class NextEventMapper {
  static NextEvent toObject(Json json) => NextEvent(
    groupName: json['groupName'],
    date: DateTime.parse(json['date']),
    players: NextEventPlayerMapper.toList(json['players']),
  );
}
