import 'package:flutter/material.dart';

/// To implement swipe to refresh
class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,

      /// Reach the database and clear records
      onRefresh: () {},
    );
  }
}
