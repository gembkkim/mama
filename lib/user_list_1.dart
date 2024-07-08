import 'package:flutter/material.dart';
import 'package:mama/user_list_data.dart';
import 'package:mama/user_list_service.dart';
//import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class UserList1 extends StatefulWidget {
  const UserList1({super.key});

  @override
  State<UserList1> createState() => _UserList1State();
}

class _UserList1State extends State<UserList1> {
  List<UserList> _userList = <UserList>[];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserListServices.getInfo().then((value) {
      setState(() {
        _userList = value;
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(loading ? "User" : "Loading..."),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            UserList userList = _userList[index];
            return ListTile(
              leading: const Icon(
                Icons.account_circle_rounded,
                color: Colors.blue,
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(userList.name),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${userList.name}(${userList.userId})"),
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: const Text("닫기"),
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: const Icon(
                  //Icons.phone_android_outlined,
                  Icons.arrow_circle_right,
                  color: Colors.red,
                ),
              ),
              title: Text("${userList.name}(${userList.userId})"),
              subtitle: Row(
                children: [
                  Text(userList.sexTy == "M" ? "남자" : "여자"),
                  const SizedBox(width: 10),
                  Text("${userList.age.toString()}세"),
                  const SizedBox(width: 10),
                  //WrappedKoreanText(userList.note),
                  Text(
                    userList.note,
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }
}
