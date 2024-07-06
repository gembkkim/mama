import 'dart:async';

import 'package:mama/user_list_data.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:mama/mssql.dart';

class UserListServices{

  //static Future<List<UserList>> getInfo() async {
  static Future<List<UserList>> getInfo() async {

    List<UserList> userList = <UserList>[];

    MSSQL().connectDbMssql();
    String jsonUserList = await MSSQL().selectDbMssql("sp_users_s");

    print("jsonUserList = ${jsonUserList.toString()}");
    userList = userFromJson(jsonUserList.toString());
    return userList;
  }
}