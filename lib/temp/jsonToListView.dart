import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mama/mssql.dart';

MSSQL ms = MSSQL();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multiple Lists with Cards'),
        ),
        body: ListsWithCards(),
      ),
    );
  }
}

class ListsWithCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample data for three lists

    ms.connectDbMssql();

    Future<String> sj = ms.selectDbMssql("sp_users_s");
    sj.then((sj) {
      final List<dynamic> dl;
      print("main.dart ::: sj = $sj"); //Json Data
      dl = json.decode(sj);
      List<String> dlUserId = json.decode(sj)["user_id"];
      List<String> dlName = json.decode(sj)["name"];
      List<int> dlAge = json.decode(sj)["age"];
      List<String> dlSexTy = json.decode(sj)["sex_ty"];
      List<String> dlNote = json.decode(sj)["note"];

      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> dlUserId = " + dlUserId[0]);
      print(dl.runtimeType);
      print(dl.toString());
    }).catchError((error) {
      print('error: $error');
    });

    List<List<String>> listsData = [
      ['Item 1', 'Item 2', 'Item 3'],
      ['Item A', 'Item B', 'Item C', 'Item D'],
      ['Item X', 'Item Y', 'Item Z'],
      ['Item P', 'Item Q', 'Item R'],
      ['Item M', 'Item N', 'Item O'],
    ];

    //var dl1=dl.;
    return ListView.builder(
      itemCount: listsData.length,
      itemBuilder: (context, index) {
        return CardList(listData: listsData[index]);
      },
    );
  }
}

class CardList extends StatelessWidget {
  final List<String> listData;

  CardList({required this.listData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('List ${listData[0]}'),
          ),
          Divider(),
          ListView.builder(
            itemCount: listData.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listData[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}