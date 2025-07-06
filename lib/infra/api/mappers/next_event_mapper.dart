import 'package:advanced_flutter/infra/api/mappers/mapper.dart';

import '../../../domain/entities/next_event.dart';
import '../../types/json.dart';
import 'next_event_player_mapper.dart';

final class NextEventMapper extends Mapper<NextEvent> {
  @override
  NextEvent toObject(Json json) => NextEvent(
    groupName: json['groupName'],
    date: DateTime.parse(json['date']),
    players: NextEventPlayerMapper().toList(json['players']),
  );
}
