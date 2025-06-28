import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
  final String initials;
  final String? photo;
  final String? position;
  final bool isConfirmed;
  final DateTime? confirmationDate;

  NextEventPlayer._({
    required this.id,
    required this.name,
    required this.initials,
    required this.isConfirmed,
    this.photo,
    this.position,
    this.confirmationDate,
  });

  factory NextEventPlayer({
    required String id,
    required String name,
    required bool isConfirmed,
    String? photo,
    String? position,
    DateTime? confirmationDate,
  }) => NextEventPlayer._(
    id: id,
    name: name,
    isConfirmed: isConfirmed,
    initials: _getInitials(name),
    photo: photo,
    position: position,
    confirmationDate: confirmationDate,
  );

  static String _getInitials(String name) {
    final names = name.toUpperCase().split(' ');
    final firstChar = names.first.split('').firstOrNull ?? '-';
    final lastChar = names.last.split('').elementAtOrNull(names.length == 1 ? 1 : 0) ?? '';
    return '$firstChar$lastChar';
  }
}

void main() {
  String initialOf(String name) => NextEventPlayer(id: '', name: name, isConfirmed: true).initials;
  test('should return the first letter of the first and last names', () {
    expect(initialOf('John Doe'), 'JD');
    expect(initialOf('John Doe Smith'), 'JS');
  });

  test('should return the first letter of the first name', () {
    expect(initialOf('John'), 'JO');
    expect(initialOf('J'), 'J');
  });
  test('should return "-" when name is empty', () {
    expect(initialOf(''), '-');
  });

  test('should convet to uppercase', () {
    expect(initialOf('John'), 'JO');
    expect(initialOf('john doe'), 'JD');
    expect(initialOf('d'), 'D');
  });
}
