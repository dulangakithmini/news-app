import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/models/item_model.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    /// To access the StoriesBloc inorder to access StreamControllers inside StoriesBloc
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Still loading');
        }
        return FutureBuilder(
          future: snapshot.data[itemId],

          /// snapshot is named as itemSnapshot just to distinguish from the snapshot of the StreamBuilder
          /// return type of itemSnapshot is not Future<ItemModel>, because we have already resolved Future with FutureBuilder
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Still loading item $itemId');
            }
            return buildTile(itemSnapshot.data);
            // return Text(itemSnapshot.data.title);
          },
        );
      },
    );
  }

  /// To create the Story tile using a given ItemModel
  Widget buildTile(ItemModel item) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text('${item.score} votes'),

      /// icon and text in the right side of the screen
      trailing: Column(
        children: [
          Icon(Icons.comment),
          Text('${item.descendants}'),
        ],
      ),
    );
  }
}
