import 'package:advanced_flutter/infra/api/clients/http_get_client.dart';

class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callCount = 0;
  Map<String, String>? headers;
  Map<String, String?>? params;
  Map<String, String>? queryString;
  dynamic response;
  Error? error;

  @override
  Future<T?> get<T>({
    required String url,
    Map<String, String>? headers,
    Map<String, String?>? params,
    Map<String, String>? queryString,
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
