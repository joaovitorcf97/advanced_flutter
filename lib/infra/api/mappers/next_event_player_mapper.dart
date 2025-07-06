import '../../../domain/entities/next_event_player.dart';
import '../../types/json.dart';

final class NextEventPlayerMapper {
  static List<NextEventPlayer> toList(JsonArr arr) =>
      arr.map(NextEventPlayerMapper.toObject).toList();

  static NextEventPlayer toObject(Json json) => NextEventPlayer(
    id: json['id'],
    name: json['name'],
    isConfirmed: json['isConfirmed'],
    photo: json['photo'],
    confirmationDate: DateTime.tryParse(json['confirmationDate'] ?? ''),
    position: json['position'],
  );
}
