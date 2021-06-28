import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, int index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {},
        );
      },
    );
  }

  /// Fake Future to be used in future of the FutureBuilder
  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'Hi',
    );
  }
}
