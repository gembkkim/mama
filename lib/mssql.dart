import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mssql_connection/mssql_connection.dart';

class MSSQL {
  String ip = "192.168.45.3",
      port = "1433",
      username = "tester",
      password = "qwer1324",
      databaseName = "testdb",
      readQuery = "sp_users_s",
      writeQuery = "sp_users_u";
  final _mssqlConnection = MssqlConnection.getInstance();

  void connectDbMssql() async {

    String ip = "192.168.45.3";
    String port = "1433";
    String username = "tester";
    String password = "qwer1324";
    String databaseName = "testdb";

    _mssqlConnection.connect(
        ip: ip,
        port: port,
        databaseName: databaseName,
        username: username,
        password: password)
        .then((value) {
      if (value) {
        debugPrint("MSSQL ::: Connection Established! ::: $value");
        // toastMessage("Connection Established", color: Colors.green);
        // pageController.nextPage(
        //     duration: const Duration(milliseconds: 500),
        //     curve: Curves.easeInOut);
      } else {
        debugPrint("MSSQL ::: Connection Failed! ::: $value");
        //toastMessage("Connection Failed", color: Colors.redAccent);
      }
    });
  }

  Future<String> selectDbMssql(String query) async {
    try {
      if (query.isEmpty) {
        debugPrint("MSSQL ::: selectDbMssql ::: query = empty!");
        return '';
      }
      debugPrint("MSSQL ::: selectDbMssql ::: query = $query");
      var startTime = DateTime.now();
      var results = await _mssqlConnection.getData(query);
      //var results = _mssqlConnection.getData(query);
      var difference = DateTime.now().difference(startTime);
      debugPrint("MSSQL ::: selectDbMssql ::: Duration = $difference and RecordCount = ${jsonDecode(results).length}");
      debugPrint("MSSQL ::: selectDbMssql ::: Results = $results");
      return results;
    } on PlatformException catch (e) {
      debugPrint("MSSQL ::: selectDbMssql ::: error = $e.message");
      return '';
    }
  }

  affectDbMssql(String query) async {
    try {
      if (query.isEmpty) {
        debugPrint("MSSQL ::: affectDbMssql ::: query = empty!");
        return;
      }
      debugPrint("MSSQL ::: affectDbMssql ::: query = $query");
      var startTime = DateTime.now();
      var results = await _mssqlConnection.writeData(writeQuery);
      var difference = DateTime.now().difference(startTime);
      //if (!mounted) return;
      debugPrint("MSSQL ::: affectDbMssql ::: Duration: $difference");
      debugPrint("MSSQL ::: affectDbMssql ::: Results = $results");
    } on PlatformException catch (e) {
      debugPrint("MSSQL ::: affectDbMssql ::: error = $e.message");
    }
  }

}