import 'package:advanced_flutter/domain/entities/errors.dart';
import 'package:advanced_flutter/infra/api/adapters/http_adapter.dart';
import 'package:advanced_flutter/infra/types/json.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';
import '../clients/client_spy.dart';

void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late String url;

  setUp(() {
    client = ClientSpy();
    client.responseJson = '''
        {
          "key1": "value1",
          "key2": "value2"
        } 
      ''';
    url = anyString();
    sut = HttpAdapter(client: client);
  });

  group('get', () {
    test('should request with correct method', () async {
      await sut.get(url: url);
      expect(client.method, 'get');
      expect(client.callCount, 1);
    });

    test('should request with correct url', () async {
      await sut.get(url: url);
      expect(client.url, url);
    });

    test('should request with default headers', () async {
      await sut.get(url: url);
      expect(client.headers?['content-type'], 'application/json');
      expect(client.headers?['accept'], 'application/json');
    });

    test('should append headers', () async {
      await sut.get(url: url, headers: {'custom-header': 'value', 'h3': 123});
      expect(client.headers?['content-type'], 'application/json');
      expect(client.headers?['accept'], 'application/json');
      expect(client.headers?['custom-header'], 'value');
      expect(client.headers?['h3'], '123');
    });

    test('should request with correct params', () async {
      url = 'http://anyurl.com/:custom-param/:another-param/:p3';
      await sut.get(
        url: url,
        params: {'custom-param': 'value', 'another-param': 'another-value', 'p3': 123},
      );
      expect(client.url, 'http://anyurl.com/value/another-value/123');
    });

    test('should request with optional params', () async {
      url = 'http://anyurl.com/:custom-param/:another-param';
      await sut.get(url: url, params: {'custom-param': 'value', 'another-param': null});
      expect(client.url, 'http://anyurl.com/value');
    });

    test('should request with invalid params', () async {
      url = 'http://anyurl.com/:p1/:p2';
      await sut.get(url: url, params: {'p3': 'v3'});
      expect(client.url, 'http://anyurl.com/:p1/:p2');
    });

    test('should request with correct queryStrings', () async {
      await sut.get(url: url, queryString: {'q1': 'v1', 'q2': 'v2'});
      expect(client.url, '$url?q1=v1&q2=v2');
    });

    test('should request with correct queryStrings and params', () async {
      url = 'http://anyurl.com/:p3/:p4';
      await sut.get(
        url: url,
        queryString: {'q1': 'v1', 'q2': 'v2'},
        params: {'p3': 'v3', 'p4': 'v4'},
      );
      expect(client.url, 'http://anyurl.com/v3/v4?q1=v1&q2=v2');
    });

    test('should throw UnexpectedError on 400', () async {
      client.simulateBadRequestEror();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<UnexpectedError>()));
    });

    test('should throw SessionExpiredError on 401', () async {
      client.simulateUnauthorizedError();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<SessionExpiredError>()));
    });

    test('should throw UnexpectedError on 403', () async {
      client.simulateForbiddenError();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<UnexpectedError>()));
    });

    test('should throw UnexpectedError on 404', () async {
      client.simulateNotFoundError();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<UnexpectedError>()));
    });

    test('should throw ServerError on 500', () async {
      client.simulateServerError();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<UnexpectedError>()));
    });

    test('should return a Map', () async {
      client.responseJson = '''
        {
          "key1": "value1",
          "key2": "value2"
        } 
      ''';
      final data = await sut.get<Json>(url: url);
      expect(data?['key1'], 'value1');
      expect(data?['key2'], 'value2');
    });

    test('should return a List', () async {
      client.responseJson = '''
        [
          {"key1": "value1"},
          {"key2": "value2"}
        ] 
      ''';
      final data = await sut.get<JsonArr>(url: url);
      expect(data?[0]['key1'], 'value1');
      expect(data?[1]['key2'], 'value2');
    });

    test('should return a Map with List', () async {
      client.responseJson = '''
        {
          "key1": "value1",
          "key2": [
            {"key3": "value3"},
            {"key4": "value4"}
          ]
        }
      ''';
      final data = await sut.get<Json>(url: url);
      expect(data?['key1'], 'value1');
      expect(data?['key2'][0]['key3'], 'value3');
      expect(data?['key2'][1]['key4'], 'value4');
    });

    test('should return null on 200 with empty response', () async {
      client.responseJson = '';
      final data = await sut.get(url: url);
      expect(data, null);
    });

    test('should return null on 204', () async {
      client.simalateNotContent();
      final data = await sut.get(url: url);
      expect(data, null);
    });
  });
}
