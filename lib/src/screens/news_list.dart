import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    /// bad practice
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          /// Center the CircularProgressIndicator
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          /// Total number of ids fetched
          itemCount: snapshot.data.length,

          itemBuilder: (context, int index) {
            bloc.fetchItem(snapshot.data[index]);
            return NewsListTile(itemId: snapshot.data[index]);

            /// String interpolation to convert the int to String
            // return Text('${snapshot.data[index]}');
            // return Text(snapshot.data[index].toString());
          },
        );
      },
    );
  }

// Widget buildList(StoriesBloc bloc) {
//   return ListView.builder(
//     itemCount: 1000,
//     itemBuilder: (context, int index) {
//       return FutureBuilder(
//         future: getFuture(),
//         builder: (context, snapshot) {
//           return snapshot.hasData
//               ? bloc.topIds
//               : Text('You can\'t see me');
//         },
//       );
//     },
//   );
// }

  /// Fake Future to be used in future of the FutureBuilder
// getFuture() {
//   return Future.delayed(
//     Duration(seconds: 2),
//     () => 'Hi',
//   );
// }
}
