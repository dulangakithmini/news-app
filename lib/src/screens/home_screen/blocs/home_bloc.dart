import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// HomeBloc
class HomeBloc extends Bloc<BlocEventBase, HomeState> {
  HomeBloc() : super(HomeState(count: 0));

  @override
  Stream<HomeState> mapEventToState(BlocEventBase event) async* {
    if (event is IncrementEvent) {
      yield HomeState(count: state.count + 1);
    } else if (event is DecrementEvent) {
      yield HomeState(count: state.count - 1);
    }
  }
}

/// State of homeBloc
class HomeState {
  final int count;

  HomeState({
    @required this.count,
  });
}

/// Bloc event base class
abstract class BlocEventBase {}

/// Increment event
class IncrementEvent extends BlocEventBase {}

/// Decrement event
class DecrementEvent extends BlocEventBase {}
