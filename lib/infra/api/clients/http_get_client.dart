import '../../types/json.dart';

abstract class HttpGetClient {
  Future<T> get<T>({required String url, Json? params});
}
