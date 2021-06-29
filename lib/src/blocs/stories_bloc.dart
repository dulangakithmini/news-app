import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final PublishSubject<List<int>> _topIds = PublishSubject<List<int>>();

  /// Works with StreamBuilders
  final BehaviorSubject<Map<int, Future<ItemModel>>> _itemsOutput =
      BehaviorSubject<Map<int, Future<ItemModel>>>();

  /// Ids are passed into this and the transformer will be connected to this
  final PublishSubject<int> _itemsFetcher = PublishSubject();

  // Stream<Map<int, Future<ItemModel>>> items;

  final _repository = Repository();

  /// Getters to streams
  Stream<List<int>> get topIds => _topIds.stream;

  /// To be listened by the StreamBuilders
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  /// Getters to sinks
  void Function(int) get fetchItem => _itemsOutput.sink.add;

  /// This creates a new ScanStreamControllers everytime it is called.
  // get item => _itemsOutput.stream.transform(_itemsTransformerOutput());
  /// _itemsTransformerOutput() should be called only once.
  /// Otherwise multiple ScanStreamControllers will be created with multiple cache maps.
  /// Therefore the stream is transformed and assigned to a new variable inside the constructor.
  ///  The new stream can be accessed with items variable.
  StoriesBloc() {
    items = _itemsOutput.stream.transform(_itemsTransformer());
  }

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
    _itemsOutput.close();
  }
}
