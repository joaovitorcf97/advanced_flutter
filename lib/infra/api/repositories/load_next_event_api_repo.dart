import '../../../domain/entities/next_event.dart';
import '../../../domain/repositories/load_next_event_repo.dart';
import '../../types/json.dart';
import '../clients/http_get_client.dart';
import '../mappers/next_event_mapper.dart';

class LoadNextEventApiRepository implements LoadNextEventResository {
  final HttpGetClient httpClient;
  final String url;

  LoadNextEventApiRepository({required this.httpClient, required this.url});

  @override
  Future<NextEvent> loadNextEvent({required String groupId}) async {
    final json = await httpClient.get<Json>(url: url, params: {'groupId': groupId});
    return NextEventMapper.toObject(json!);
  }
}
