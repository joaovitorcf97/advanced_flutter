import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

class LoadNextEventRepository {
  String? groupId;
  var callCount = 0;

  Future<void> loadNextEvent({required String groupId}) async {
    this.groupId = groupId;
    callCount++;
  }
}

class NextEventLoader {
  final LoadNextEventRepository repository;

  NextEventLoader({required this.repository});

  Future<void> call({required String groupId}) async {
    await repository.loadNextEvent(groupId: groupId);
  }
}

void main() {
  test('should load event data from a repository', () async {
    final groupId = Random().nextInt(50000).toString();
    final repo = LoadNextEventRepository();
    final sut = NextEventLoader(repository: repo);
    await sut(groupId: groupId);

    expect(repo.groupId, equals(groupId));
    expect(repo.callCount, equals(1));
  });
}
