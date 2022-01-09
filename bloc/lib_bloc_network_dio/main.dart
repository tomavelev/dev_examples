import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:portfolio_platform_bloc/models.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'dart:convert';
import 'package:rx_bloc_list/models.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';


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
  static const int LIMIT = 10;
  final _paginatedList = BehaviorSubject<PaginatedList<Profile>>.seeded(
    PaginatedList<Profile>(
      list: [],
      pageSize: LIMIT,
    ),
  );
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
  Stream<PaginatedList<Profile>> get profiles => _paginatedList.stream;

  @override
  void dispose() {
    _paginatedList.close();
    super.dispose();
  }

  @override
  void loadPage(int offset, {bool force = false}) =>
      _loadPage(offset, force: force);
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
                      if (state.data == null) {
                        return const Text("Loading");
                      }
                      if (state.data?.totalCount == 0) {
                        return const Text("No Data");
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          if (state.data != null &&
                              state.data!.length > index) {
                            final profile = state.data![index];
                            return ProfileListItem(profile);
                          }
                          return const CircularProgressIndicator();
                        },
                        itemCount: state.data!.totalCount,
                      );
                    })),
          ],
        ));
  }
}

class ProfileListItem extends StatelessWidget {
  final Profile profile;

  const ProfileListItem(this.profile, {Key? key}) : super(key: key);

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

extension LoadPageExt on PPBloc {

  void _loadPage(int offset, {bool force = true}) {
    var dio = Dio() ;
    // dio.interceptors.add(AuthInterCeptor());
    dio.get("https://programtom.com/Portfolio_Platform/publicDATA/profile/indexJsonExt.php").then((response) {
          Map<String, dynamic> dataResult = json.decode(response.data);

          if (force) {

            _paginatedList.value = PaginatedList<Profile>(
              list: [],
              pageSize: PPBloc.LIMIT,
            );
          }
          var snapshot = dataResult["list"] != null
              ? (asList(dataResult["list"]) as List)
                  .map((i) => Profile.fromJson(i))
                  .toList()
              : <Profile>[];

          _paginatedList.add(PaginatedList(
              pageSize: PPBloc.LIMIT, list: snapshot, totalCount: dataResult['count']));

      });
  }

  asList(jsonBody) {
    if (jsonBody is String) {
      return jsonDecode(jsonBody);
    } else {
      return jsonBody;
    }
  }
}
