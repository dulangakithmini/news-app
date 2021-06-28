import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/blocs/stories_provider.dart';

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
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('No data');
        }
        return ListView.builder(
          /// Total number of ids fetched
          itemCount: snapshot.data.length,

          itemBuilder: (context, int index) {
            return Text(snapshot.data[index]);
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
