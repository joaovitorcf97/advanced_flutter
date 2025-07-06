import 'package:advanced_flutter/infra/api/clients/http_get_client.dart';
import 'package:advanced_flutter/infra/types/json.dart';

final class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callCount = 0;
  Json? headers;
  Json? params;
  Json? queryString;
  dynamic response;
  Error? error;

  @override
  Future<T?> get<T>({
    required String url,
    Json? headers,
    Json? params,
    Json? queryString,
  }) async {
    this.url = url;
    this.headers = headers;
    this.params = params;
    this.queryString = queryString;
    callCount++;
    if (error != null) {
      throw error!;
    }
    return response;
  }
}
