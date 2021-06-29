import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';

/// To implement swipe to refresh
class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      child: child,

      /// Reach the database and clear records
      onRefresh: () async {
        await bloc.clearCache();
      },
    );
  }
}
