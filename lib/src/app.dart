import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/src/screens/home_screen/blocs/home_cubit.dart';
import 'package:news/src/screens/home_screen/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (ctx) => HomeCubit(),
        child: HomeScreen(),
      ),
    );
  }
}
