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
  NextEventPlayer makeSut(String name) {
    return NextEventPlayer(id: '', name: name, isConfirmed: true);
  }

  test('should return the first letter of the first and last name', () {
    expect(makeSut('João Vitor').getInitials(), 'JV');
    expect(makeSut('Pedro Henrique').getInitials(), 'PH');
    expect(makeSut('Maria Eduarda Silva').getInitials(), 'MS');
  });
}
