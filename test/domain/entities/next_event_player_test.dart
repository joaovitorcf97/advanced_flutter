import 'package:advanced_flutter/domain/entities/next_event_player.dart';

import 'package:flutter_test/flutter_test.dart';

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
