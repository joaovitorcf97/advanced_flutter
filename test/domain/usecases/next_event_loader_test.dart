import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

class NextEventLoader {
  final LoadNextEventResository repo;

  NextEventLoader({required this.repo});

  Future<void> call({required String groupId}) async {
    await repo.loadNextEvent(groupId: groupId);
  }
}

abstract class LoadNextEventResository {
  Future<void> loadNextEvent({required String groupId});
}

class LoadNextEventMockResository implements LoadNextEventResository {
  String? groupId;
  var callCount = 0;

  @override
  Future<void> loadNextEvent({required String groupId}) async {
    this.groupId = groupId;
    callCount++;
  }
}

void main() {
  test('should load event data from a repository', () async {
    final groupId = Random().nextInt(50000).toString();
    final repo = LoadNextEventMockResository();
    final sut = NextEventLoader(repo: repo);
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callCount, 1);
  });
}
