// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBean _$AccountBeanFromJson(Map<String, dynamic> json) => AccountBean(
      id: json['id'] as int?,
      name: json['name'] as String,
      account: json['account'] as String?,
      pwd: json['pwd'] as String?,
      customFields: (json['customFields'] as List<dynamic>?)
          ?.map((e) => CustomField.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..isShowSuspension = json['isShowSuspension'] as bool;

Map<String, dynamic> _$AccountBeanToJson(AccountBean instance) =>
    <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'pwd': instance.pwd,
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
