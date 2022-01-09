import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:portfolio_platform_bloc/models.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_list/models.dart';

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
  final profilesList = <Profile>[Profile(id: 1, name: "dummy", picture: "")];
  int profilesTotalCount = -1;
  String? messageCache;
  PPNetworkRepository ppNetworkRepository;

  PPBloc(this.ppNetworkRepository) {
    loadPage(0);
  }

  @override
  Stream<String?> get message => Future<String?>.value(messageCache).asStream();

  @override
  PPBlocEvents get events => this;

  @override
  PPBlocStates get states => this;

  @override
  Stream<PaginatedList<Profile>> get profiles =>
      Future.value(PaginatedList<Profile>(
          list: profilesList, pageSize: profilesTotalCount))
          .asStream();

  @override
  void loadPage(int offset, {bool force = true}) {
    profilesList.add(Profile(id: 11, name: "sss", picture: ""));
    profilesTotalCount++;
  }
}

class PaginatedListPage extends StatelessWidget {
  const PaginatedListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            RxBlocBuilder<PPBlocType, String?>(
                state: (bloc) => bloc.states.message,
                builder: (context, state, bloc) {
                  if (state.data == null) {
                    return Container();
                  } else {
                    return Text(state.data!);
                  }
                }),
            Expanded(
                child: RxBlocBuilder<PPBlocType, PaginatedList<Profile>>(
                    state: (bloc) => bloc.states.profiles,
                    builder: (context, state, bloc) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final profile = state.data!.list[index];
                          return ProfileListItem(profile);
                        },
                        itemCount: state.itemCount,
                      );
                    })),
          ],
        ));
  }
}

class ProfileListItem extends StatelessWidget {
  final Profile profile;

  ProfileListItem(this.profile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(profile.name);
  }
}

class PPNetworkRepository {}

abstract class PPBlocType extends RxBlocTypeBase {
  PPBlocEvents get events;

  PPBlocStates get states;
}

abstract class PPBlocStates {
  Stream<String?> get message;

  Stream<PaginatedList<Profile>> get profiles;
}

abstract class PPBlocEvents {
  void loadPage(int offset, {bool force = true});
}
