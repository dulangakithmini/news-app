import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_bloc.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading');
        }
        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Loading');
            }

            /// passes the comment list and ItemModel
            return buildList(itemSnapshot.data, snapshot.data);
            // return buildTitle(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),

      /// Container is in the top of the screen and stretch from left to right
      alignment: Alignment.topCenter,
      child: Text(
        item.title,

        /// Center the text
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Build the comment list
  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    /// map() returns an Iterable.
    /// Since this will be added to the list of children in the ListView, it is converted to a list with .toList()
    final commentsList = item.kids.map(
      (kidId) {
        return Comment(
          itemId: kidId,
          itemMap: itemMap,
        );
      },
    ).toList();

    return ListView(
      children: <Widget>[
        buildTitle(item),
      ],
    );
  }
}
