import 'package:json_annotation/json_annotation.dart';

import 'dart:convert';
part 'models.g.dart';

abstract class QueryResult<T> {
  List<T> list = [];
  var count = 0;

  QueryResult(this.list, this.count);
}

@JsonSerializable()
class ProfileQueryResult extends QueryResult<Profile> {
  ProfileQueryResult(List<Profile> list, int count) : super(list, count);

  factory ProfileQueryResult.fromJson(Map<String, dynamic> json) => _$ProfileQueryResultFromJson(json);

}

@JsonSerializable()
class Profile {
  int id;
  String name;
  String? summary;
  String picture;

  Profile({
    required this.id,
    required this.name,
    this.summary,
    required this.picture,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as int,
          name: json['name'],
          summary: json['summary'],
          picture: json['picture'],
        );
}

asList(jsonBody) {
  if (jsonBody is String) {
    return jsonDecode(jsonBody);
  } else {
    return jsonBody;
  }
}