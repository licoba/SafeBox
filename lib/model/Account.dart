class AccountBean {
   int? id;
   String name; // 名字
   String account; // 账号
   String pwd; // 密码

  AccountBean({
    this.id,
    required this.name,
    required this.account,
    required this.pwd,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'account': account,
      'pwd': pwd,
    };
  }

  @override
  String toString() {
    return 'AccountBean{id: $id, name: $name, account: $account, pwd: $pwd}';
  }
}

