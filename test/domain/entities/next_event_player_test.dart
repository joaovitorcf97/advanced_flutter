import 'package:advanced_flutter/domain/entities/next_event_player.dart';

import 'package:flutter_test/flutter_test.dart';

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

  test('should ignore extra whitespaces', () {
    expect(initialOf('John Doe '), 'JD');
    expect(initialOf(' John Doe'), 'JD');
    expect(initialOf(' John Doe    '), 'JD');
    expect(initialOf(' John    Doe '), 'JD');
    expect(initialOf(' '), '-');
    expect(initialOf('  '), '-');
  });
}
