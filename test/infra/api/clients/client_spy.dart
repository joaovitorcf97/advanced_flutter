import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';

final class ClientSpy implements Client {
  String? method;
  int callCount = 0;
  String? url;
  Map<String, String>? headers;
  String responseJson = '';
  int statusCode = 200;

  void simulateBadRequestEror() => statusCode = 400;
  void simalateNotContent() => statusCode = 204;
  void simulateUnauthorizedError() => statusCode = 401;
  void simulateForbiddenError() => statusCode = 403;
  void simulateNotFoundError() => statusCode = 404;
  void simulateServerError() => statusCode = 500;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    method = request.method;
    return Future.value(StreamedResponse(Stream.fromIterable([]), 200));
  }

  @override
  void close() {}

  @override
  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    method = 'get';
    callCount++;
    this.url = url.toString();
    this.headers = headers;
    return Response(responseJson, statusCode);
  }

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<Response> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }
}
