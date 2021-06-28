import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();

  final _repository = Repository();

  /// Getters to streams
  Stream<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    /// Fetch Ids from the repository
    final ids = await _repository.fetchTopIds();

    /// Add to the PublishSubject
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }
}
