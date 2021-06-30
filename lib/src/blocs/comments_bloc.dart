import 'dart:async';

import 'package:news/src/models/item_model.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final PublishSubject<int> _commentsFetcher = PublishSubject<int>();
  final BehaviorSubject<Map<int, Future<ItemModel>>> _commentsOutput =
      BehaviorSubject<Map<int, Future<ItemModel>>>();

  /// Getters to stream
  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  /// Getters to sinks
  void Function(int event) get fetchItemWithComments =>
      _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  StreamTransformer<int, dynamic> _commentsTransformer() {}

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
