import 'package:clean_todo/core/domain/usecases/sync.dart';

class SyncTasks extends SyncUseCase {
  @override
  SyncResults call() {
    return SyncResults(synced: false, message: "Failed to sync");
  }
}
