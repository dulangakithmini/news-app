import 'dart:async';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final PublishSubject<int> _commentsFetcher = PublishSubject<int>();
  final BehaviorSubject<Map<int, Future<ItemModel>>> _commentsOutput =
      BehaviorSubject<Map<int, Future<ItemModel>>>();

  final _repository = Repository();

  /// Getters to stream
  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  /// Getters to sinks
  void Function(int event) get fetchItemWithComments =>
      _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  StreamTransformer<int, dynamic> _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        /// Returns a future
        cache[id] = _repository.fetchItem(id);

        /// Above line returns a future.
        /// Reference the Future and after the Future is resolved, the inner function will be invoked.
        /// Inner function is fetched with the ItemModel just fetched.
        cache[id].then((ItemModel item) {
          /// Recursively get kids and fetch
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });

        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
