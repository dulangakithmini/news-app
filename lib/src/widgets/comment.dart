import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({this.itemId, this.itemMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Text('Still loading comments');
        }

        /// Create a Widget list with top comments
        final children = <Widget>[
          Text(snapshot.data.text),
        ];

        /// For each kidId, Create Comments recursively and add to the children list
        snapshot.data.kids.forEach((kidId) {
          children.add(
            Comment(
              itemId: kidId,
              itemMap: itemMap,
            ),
          );
        });

        return Column(
          children: children,
          // children: [
          // Text(snapshot.data.text),
          // ],
        );
        // return Text(snapshot.data.text);
      },
    );
  }
}
