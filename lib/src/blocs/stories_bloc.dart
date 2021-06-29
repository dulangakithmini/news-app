import 'package:news/src/models/item_model.dart';
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

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        cache[id] = _repository.fetchItem(id);

        /// The returned cache is carried over to the next time the function is invoked
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
  }
}
