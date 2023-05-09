import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lpinyin/lpinyin.dart';

part 'AccountBean.g.dart';

@JsonSerializable()
class AccountBean extends ISuspensionBean {
  int? id;
  String? title;
  List<CustomField>? customFields;

  AccountBean({this.id, this.customFields});

  factory AccountBean.fromJson(Map<String, dynamic> srcJson) =>
      _$AccountBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AccountBeanToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customFields': customFields?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'AccountBean{id: $id, customFields: $customFields}  tag：${getSuspensionTag()}';
  }

  // 排序的索引
  @override
  String getSuspensionTag() {
    String name = customFields?[0].content?[0] ?? "";
    return PinyinHelper.getPinyin(name)[0]; // 也就是名称的值
  }
}

@JsonSerializable()
class CustomField extends Object {
  String? createTime;
  String? name;
  String? content;

  // 定义构造函数
  CustomField({
    required this.name,
    required this.content,
    String? createTime,
  }) : createTime = createTime ?? DateTime.now().toString();

  factory CustomField.fromJson(Map<String, dynamic> srcJson) =>
      _$CustomFieldFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CustomFieldToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'createTime': createTime,
      'name': name,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'CustomField{createTime: $createTime, name: $name, content: $content}';
  }
}
