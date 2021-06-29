import 'package:flutter/material.dart';

/// A stand in widget to load until the data is loaded
class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),

        /// Divider between each tile
        Divider(
          thickness: 1.5,
          height: 8.0,
        ),
      ],
    );
  }

  Widget buildContainer() {
    return Expanded(
      child: Container(
        color: Colors.grey,
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      ),
    );
  }
}
