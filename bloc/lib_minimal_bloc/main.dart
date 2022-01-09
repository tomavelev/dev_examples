import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:rx_bloc/rx_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio Platform with BloC',
      home: RxBlocProvider<PPBlocType>(
        create: (context) => PPBloc(PPNetworkRepository()),
        child: const PaginatedListPage(),
      ),
    );
  }
}

class PPBloc extends RxBlocBase
    implements PPBlocStates, PPBlocEvents, PPBlocType {
  PPNetworkRepository ppNetworkRepository;

  PPBloc(this.ppNetworkRepository);

  @override
  Stream<String> get message =>
      Future<String>.value("message from the bloc").asStream();

  @override
  PPBlocEvents get events => this;

  @override
  PPBlocStates get states => this;
}

class PaginatedListPage extends StatelessWidget {
  const PaginatedListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RxBlocBuilder<PPBlocType, String>(
          state: (bloc) => bloc.states.message,
          builder: (context, state, bloc) {
            return Text(state.data == null ? "data is null" : state.data!);
          }),
    );
  }
}

class PPNetworkRepository {}

abstract class PPBlocType extends RxBlocTypeBase {
  PPBlocEvents get events;

  PPBlocStates get states;
}

abstract class PPBlocStates {
  Stream<String> get message;
}

abstract class PPBlocEvents {}
