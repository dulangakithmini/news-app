import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;

  /// To decide the indentation of comments
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
          // return Text('Still loading comments');
        }

        /// Create a Widget list with top comments
        final children = <Widget>[
          ListTile(
            title: buildText(snapshot.data),

            /// If the comment is deleted, the by property = ''
            subtitle: snapshot.data.by == ''

                /// If empty, display 'Deleted'
                ? Text('Deleted')
                : Text(snapshot.data.by),
            contentPadding: EdgeInsets.only(left: depth * 16.0, right: 16),
          ),
          Divider(
            thickness: 1.5,
          ),
          // Text(snapshot.data.text),
        ];

        /// For each kidId, Create Comments recursively and add to the children list
        snapshot.data.kids.forEach((kidId) {
          children.add(
            Comment(
              itemId: kidId,
              itemMap: itemMap,

              /// Increment the current depth by 1
              depth: depth + 1,
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

  Widget buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');

    return Text(text);
  }
}
