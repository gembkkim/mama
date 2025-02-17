import 'package:http/http.dart' as http;
import 'package:mama/temp/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Services{
  static const String url = "https://jsonplaceholder.typicode.com/users";
  static Future<List<User>> getInfo() async{
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        print("response.body = ${response.body}");
        final List<User> user = userFromJson(response.body);
        return user;
      } else {
        Fluttertoast.showToast(msg: '에러발생! 다시 수행하시오!');
        return <User>[];
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      return <User>[];
    }
  }
}