import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/src/screens/home_screen/blocs/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gate Keeping app'),
      ),
      body: BlocProvider<HomeCubit>(
        create: (ctx) => HomeCubit(),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              BlocBuilder<HomeCubit, int>(
                builder: (ctx, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('-'),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          state.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('+'),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
