import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();

  /// Getters to streams
  Stream<List<int>> get topIds => _topIds.stream;

  dispose() {
    _topIds.close();
  }
}
