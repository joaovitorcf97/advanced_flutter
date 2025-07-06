import 'package:advanced_flutter/domain/entities/next_event.dart';

abstract interface class LoadNextEventResository {
  Future<NextEvent> loadNextEvent({required String groupId});
}
