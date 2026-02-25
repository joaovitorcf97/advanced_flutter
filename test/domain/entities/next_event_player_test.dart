import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
  final String? photo;
  final String? position;
  final bool isConfirmed;
  final DateTime? confirmationDate;

  NextEventPlayer({
    required this.id,
    required this.name,
    this.photo,
    this.position,
    this.isConfirmed = false,
    this.confirmationDate,
  });

  String getInitials() {
    final names = name.split(' ');
    return '${names[0][0]}${names[1][0]}';
  }
}

void main() {
  test('should return the first letter of the first and last name', () {
    final player = NextEventPlayer(
      id: '',
      name: 'João Vitor',
      isConfirmed: true,
    );

    expect(player.getInitials(), 'JV');
  });
}
