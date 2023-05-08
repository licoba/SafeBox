// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBean _$AccountBeanFromJson(Map<String, dynamic> json) => AccountBean(
      id: json['id'] as int?,
      customFields: (json['customFields'] as List<dynamic>?)
          ?.map((e) => CustomField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountBeanToJson(AccountBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customFields': instance.customFields,
    };

CustomField _$CustomFieldFromJson(Map<String, dynamic> json) => CustomField(
      name: json['name'] as String?,
      content: json['content'] as String?,
      createTime: json['createTime'] as String?,
    );

Map<String, dynamic> _$CustomFieldToJson(CustomField instance) =>
    <String, dynamic>{
      'createTime': instance.createTime,
      'name': instance.name,
      'content': instance.content,
    };
