import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    /// To access the StoriesBloc inorder to access StreamControllers inside StoriesBloc
    final bloc = StoriesProvider.of(context);

    return Container();
  }
}
