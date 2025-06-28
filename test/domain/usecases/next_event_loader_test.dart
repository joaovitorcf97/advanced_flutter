import 'package:advanced_flutter/domain/entities/next_event.dart';
import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:advanced_flutter/domain/repositories/load_next_event_repo.dart';
import 'package:advanced_flutter/domain/usecases/next_event_loader.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

class LoadNextEventSpyResository implements LoadNextEventResository {
  String? groupId;
  var callCount = 0;
  NextEvent? output;
  Error? error;

  @override
  Future<NextEvent> loadNextEvent({required String groupId}) async {
    this.groupId = groupId;
    callCount++;
    if (error != null) throw error!;
    return output!;
  }
}

void main() {
  late String groupId;
  late LoadNextEventSpyResository repo;
  late NextEventLoader sut;

  setUp(() {
    groupId = anyString();
    repo = LoadNextEventSpyResository();
    repo.output = NextEvent(
      [
        NextEventPlayer(id: '1', name: 'John Doe', isConfirmed: true),
        NextEventPlayer(id: '2', name: 'Jane Smith', isConfirmed: false),
      ],
      groupName: 'Test Group',
      date: DateTime.now(),
    );
    sut = NextEventLoader(repo: repo);
  });

  test('should load event data from a repository', () async {
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callCount, 1);
  });

  test('should return event data on success', () async {
    final event = await sut(groupId: groupId);
    expect(event.groupName, repo.output?.groupName);
    expect(event.date, repo.output?.date);
    expect(event.players.length, 2);
    expect(event.players[0].id, repo.output?.players[0].id);
    expect(event.players[0].name, repo.output?.players[0].name);
    expect(event.players[0].initials, isNotEmpty);
    expect(event.players[0].isConfirmed, repo.output?.players[0].isConfirmed);
    expect(event.players[1].id, repo.output?.players[1].id);
    expect(event.players[1].name, repo.output?.players[1].name);
    expect(event.players[1].initials, isNotEmpty);
    expect(event.players[1].isConfirmed, repo.output?.players[1].isConfirmed);
  });

  test('should rethrow on error', () async {
    final error = Error();
    repo.error = error;
    final future = sut(groupId: groupId);
    expect(future, throwsA(error));
  });
}
