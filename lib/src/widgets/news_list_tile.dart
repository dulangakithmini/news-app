import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/models/item_model.dart';

import 'loading_container.dart';

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
          /// Load the stand in widget if the data is not loaded
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],

          /// snapshot is named as itemSnapshot just to distinguish from the snapshot of the StreamBuilder
          /// return type of itemSnapshot is not Future<ItemModel>, because we have already resolved Future with FutureBuilder
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              /// Load the stand in widget if the data is not loaded
              return LoadingContainer();
            }

            /// context is sent to be used by pushNamed in onTap
            return buildTile(context, itemSnapshot.data);
            // return Text(itemSnapshot.data.title);
          },
        );
      },
    );
  }

  /// To create the Story tile using a given ItemModel
  /// /// context is received to be used by pushNamed in onTap
  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),

          /// icon and text in the right side of the screen
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
          onTap: () {
            print('${item.id} was tapped!');
            Navigator.pushNamed(context, '/${item.id}');
          },
        ),

        /// Divider between each tile
        Divider(
          thickness: 1.5,
          height: 8.0,
        ),
      ],
    );
  }
}
