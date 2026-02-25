import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
  late final String initials;
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
  }) {
    initials = _getInitials();
  }

  String _getInitials() {
    final names = name.split(' ');
    final firstChar = names[0][0];
    final lastChar = names.last[0];

    return '$firstChar$lastChar';
  }
}

void main() {
  String initialsOf(String name) {
    return NextEventPlayer(id: '', name: name, isConfirmed: true).initials;
  }

  test('should return the first letter of the first and last name', () {
    expect(initialsOf('João Vitor'), equals('JV'));
    expect(initialsOf('Pedro Henrique'), equals('PH'));
    expect(initialsOf('Maria Eduarda Silva'), equals('MS'));
  });
}
