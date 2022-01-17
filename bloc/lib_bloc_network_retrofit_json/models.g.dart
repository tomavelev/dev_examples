// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileQueryResult _$ProfileQueryResultFromJson(Map<String, dynamic> json) =>
    ProfileQueryResult(
      (json['list'] as List<dynamic>)
          .map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['count'] as int,
    );

Map<String, dynamic> _$ProfileQueryResultToJson(ProfileQueryResult instance) =>
    <String, dynamic>{
      'list': instance.list,
      'count': instance.count,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as int,
      name: json['name'] as String,
      summary: json['summary'] as String?,
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'summary': instance.summary,
      'picture': instance.picture,
    };
