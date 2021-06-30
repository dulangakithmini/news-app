import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/screens/home_screen/blocs/home_bloc.dart';
import 'package:news/src/screens/news_detail.dart';

// import 'package:news/src/screens/home_screen/home_screen.dart';
import 'package:news/src/screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        /// Example - show NewsList page on the screen
        // onGenerateRoute: (RouteSettings settings) {
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       return NewsList();
        //     },
        //   );
        // },
        home: BlocProvider<HomeBloc>(
          create: (ctx) => HomeBloc(),
          child: NewsList(),
        ),

        /// When tap on a story, when pushNamed is called, onGenerateRoute is invoked.
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    /// Checks the route name and return the widget accordingly
    if (settings.name != '/') {
      return MaterialPageRoute(
        builder: (context) {
          return NewsDetail();
        },
      );
    }
  }
}
