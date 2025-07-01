import 'package:advanced_flutter/domain/entities/next_event.dart';
import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:advanced_flutter/domain/repositories/load_next_event_repo.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';

class LoadNextEventApiRepository implements LoadNextEventResository {
  final HttpGetClient httpClient;
  final String url;

  LoadNextEventApiRepository({required this.httpClient, required this.url});

  @override
  Future<NextEvent> loadNextEvent({required String groupId}) async {
    final event = await httpClient.get(url: url, params: {'groupId': groupId});

    return NextEvent(
      groupName: event['groupName'],
      date: DateTime.parse(event['date']),
      players:
          event['players']
              .map<NextEventPlayer>(
                (player) => NextEventPlayer(
                  id: player['id'],
                  name: player['name'],
                  isConfirmed: player['isConfirmed'],
                  photo: player['photo'],
                  confirmationDate: DateTime.tryParse(player['confirmationDate'] ?? ''),
                  position: player['position'],
                ),
              )
              .toList(),
    );
  }
}

abstract class HttpGetClient {
  Future<dynamic> get({required String url, Map<String, String>? params}) async {}
}

class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callCount = 0;
  Map<String, String>? params;
  dynamic response;
  Error? error;

  @override
  Future<dynamic> get({required String url, Map<String, String>? params}) async {
    this.url = url;
    this.params = params;
    callCount++;
    if (error != null) {
      throw error!;
    }
    return response;
  }
}

void main() {
  late String groupId;
  late String url;
  late HttpGetClientSpy httpClient;
  late LoadNextEventApiRepository sut;

  setUp(() {
    groupId = anyString();
    url = anyString();
    httpClient = HttpGetClientSpy();
    httpClient.response = {
      "groupName": "any_name",
      "date": "2024-08-30T10:30:00",
      "players": [
        {"id": "id_1", "name": "name 1", "isConfirmed": true},
        {
          "id": "id_2",
          "name": "name 2",
          "isConfirmed": true,
          "photo": "photo_2",
          "confirmationDate": "2024-08-29T11:00:00",
          "position": "position_2",
        },
      ],
    };
    sut = LoadNextEventApiRepository(httpClient: httpClient, url: url);
  });
  test('should call HttpClient with correct input', () async {
    await sut.loadNextEvent(groupId: groupId);
    expect(httpClient.url, url);
    expect(httpClient.params, {'groupId': groupId});
    expect(httpClient.callCount, 1);
  });

  test('should return NextEvent on success', () async {
    final event = await sut.loadNextEvent(groupId: groupId);
    expect(event.groupName, 'any_name');
    expect(event.date, DateTime(2024, 8, 30, 10, 30));
    expect(event.players[0].id, 'id_1');
    expect(event.players[0].name, 'name 1');
    expect(event.players[0].isConfirmed, true);

    expect(event.players[1].id, 'id_2');
    expect(event.players[1].name, 'name 2');
    expect(event.players[1].isConfirmed, true);
    expect(event.players[1].photo, 'photo_2');
    expect(event.players[1].confirmationDate, DateTime(2024, 8, 29, 11, 0));
    expect(event.players[1].position, 'position_2');
  });

  test('should rethrow on error', () async {
    final error = Error();
    httpClient.error = error;
    final future = sut.loadNextEvent(groupId: groupId);
    expect(future, throwsA(error));
  });
}
