import 'package:advanced_flutter/infra/api/mappers/mapper.dart';

import '../../../domain/entities/next_event_player.dart';
import '../../types/json.dart';

final class NextEventPlayerMapper extends Mapper<NextEventPlayer> {
  @override
  NextEventPlayer toObject(Json json) => NextEventPlayer(
    id: json['id'],
    name: json['name'],
    isConfirmed: json['isConfirmed'],
    photo: json['photo'],
    confirmationDate: DateTime.tryParse(json['confirmationDate'] ?? ''),
    position: json['position'],
  );
}
