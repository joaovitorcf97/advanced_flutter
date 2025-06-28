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
  late String groupId;
  late LoadNextEventMockResository repo;
  late NextEventLoader sut;

  setUp(() {
    groupId = Random().nextInt(50000).toString();
    repo = LoadNextEventMockResository();
    sut = NextEventLoader(repo: repo);
  });

  test('should load event data from a repository', () async {
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callCount, 1);
  });
}
