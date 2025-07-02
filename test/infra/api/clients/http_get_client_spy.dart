import 'package:advanced_flutter/infra/api/clients/http_get_client.dart';
import 'package:advanced_flutter/infra/types/json.dart';

class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callCount = 0;
  Json? params;
  dynamic response;
  Error? error;

  @override
  Future<T> get<T>({required String url, Json? params}) async {
    this.url = url;
    this.params = params;
    callCount++;
    if (error != null) {
      throw error!;
    }
    return response;
  }
}
