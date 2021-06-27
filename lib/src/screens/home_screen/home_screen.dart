import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/src/screens/home_screen/blocs/home_bloc.dart';

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
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              // bloc: BlocProvider.of<HomeCubit>(context),
              builder: (ctx, state) {
                return Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(ctx).add(DecrementEvent());
                        },
                        child: Text('-'),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        state.count.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(ctx).add(IncrementEvent());
                        },
                        child: Text('+'),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(ctx).add(SetHomeEvent(150));
                        },
                        child: Text('SET'),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
