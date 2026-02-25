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
    final firstChar = names[0][0];
    final lastChar = names.last[0];

    return '$firstChar$lastChar';
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

    final player2 = NextEventPlayer(
      id: '',
      name: 'Pedro Henrique',
      isConfirmed: false,
    );

    expect(player2.getInitials(), 'PH');

    final player3 = NextEventPlayer(
      id: '',
      name: 'Maria Eduarda Silva',
      isConfirmed: true,
    );

    expect(player3.getInitials(), 'MS');
  });
}
