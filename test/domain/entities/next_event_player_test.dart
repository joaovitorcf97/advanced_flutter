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
    this.photo,
    this.position,
    this.isConfirmed = false,
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
    initials: _getInitials(name),
    photo: photo,
    position: position,
    isConfirmed: isConfirmed,
    confirmationDate: confirmationDate,
  );

  static String _getInitials(String name) {
    final names = name.toUpperCase().trim().split(' ');
    final firstChar = names.first.split('').firstOrNull ?? '--';
    final lastChar =
        names.last.split('').elementAtOrNull(names.length == 1 ? 1 : 0) ?? '';

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

  test('should return the first letter of the first of the first name', () {
    expect(initialsOf('João'), equals('JO'));
    expect(initialsOf('J'), equals('J'));
  });

  test('should return "-" when the name empty', () {
    expect(initialsOf(''), equals('--'));
  });

  test('should convert to uppercase', () {
    expect(initialsOf('joão'), equals('JO'));
    expect(initialsOf('pedro Santos'), equals('PS'));
    expect(initialsOf('maria vitoria'), equals('MV'));
    expect(initialsOf('m'), equals('M'));
  });

  test('should ignore extra whitespace', () {
    expect(initialsOf('joão Vitor '), equals('JV'));
    expect(initialsOf('pedro Santos    '), equals('PS'));
    expect(initialsOf('  maria   vitoria '), equals('MV'));
    expect(initialsOf('m '), equals('M'));
    expect(initialsOf('   J    '), equals('J'));
    expect(initialsOf('   '), equals('--'));
  });
}
