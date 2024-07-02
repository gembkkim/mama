import 'package:flutter/material.dart';
import 'package:mama/other.dart';
import 'package:mama/other1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mama-app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home",
            style: TextStyle(
              color: Colors.black, //텍스트 색 지정
              fontSize: 20, //폰트 사이즈
              fontWeight: FontWeight.normal,
            )
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0.0,
      ),
      body:Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Hello1",
              style: TextStyle(
                color: Colors.black, //텍스트 색 지정
                fontSize: 20, //폰트 사이즈
                fontWeight: FontWeight.normal,
              )//텍스트 굵기
            ),
            const SizedBox(height: 20),
            const Text(
                "Hello2",
                style: TextStyle(
                  color: Colors.black, //텍스트 색 지정
                  fontSize: 20, //폰트 사이즈
                  fontWeight: FontWeight.normal,
                )//텍스트 굵기
            ),
            const SizedBox(height: 20),
            const Text(
                "Hello3",
                style: TextStyle(
                  color: Colors.black, //텍스트 색 지정
                  fontSize: 20, //폰트 사이즈
                  fontWeight: FontWeight.normal,
                )//텍스트 굵기
            ),
            const SizedBox(height: 20),
            TextButton(
              child: Text(
                  "Text button : Other 페이지 호출"
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey,
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OtherPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              child: Text(
                  "Text button : Other1 페이지 호출"
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey,
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Other1Page()),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              child: Text(
                "Text button :  : Snack Bar Action Message"
             ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey,
              ),
              onPressed: (){
                //스넥바 호출하는 부분이 새로운 버젼에서 아래와 같이 바뀌었다.
                //스넥바와 토스트는 비슷한 동작을 한다.
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('My Snack'),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'ACTION',
                    onPressed: () {
                      print('Snack Bar Action is clicked');
                    },
                  ),
                ));
                //print('TextButton is clicked!!!');
                //print("Button Show me is clicked!!!");
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                print('Elevated button');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('My snack bar message',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,

                    ),
                  ),
                  backgroundColor: Colors.grey[600],
                  duration: const Duration(seconds: 3),
                  // 버튼 액션을 넣을때 사용하는 방법
                )
                );

              },
              child: Text('Elevated button : Snack Bar Message'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
                // button의 모서리 둥근 정도를 바꿀 수 있음
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0.0,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: (){
                print('Outlined button');
              },
              child: Text('Outlined button'),
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  side: BorderSide(
                    color: Colors.grey,
                    width: 3.0,
                  )
              ),
            ),
            const SizedBox(height: 20),
            // 4. TextButton에 icon 넣기
            TextButton.icon(
              // 버튼을 비활성화 하는 경우 onPressed 속성에 null값 줌
              onPressed: null,
              icon: Icon(Icons.home,
                size: 30.0,
              ),
              label: Text('Go home'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black54,
                // 비활성화 된 버튼의 색상을 바꿀때는 disabled- 사용
                disabledForegroundColor: Colors.pink.withOpacity(0.20),
                disabledBackgroundColor: Colors.pink.withOpacity(0.20),
              ),
            ),
            const SizedBox(height: 20),
            // 5. ButtonBar : 화면에 끝정렬해서 버튼 나타나게 해 줌
            ButtonBar(
              //중앙정렬
              alignment: MainAxisAlignment.center,
              //padding 적용
              buttonPadding: EdgeInsets.all(20),
              children: [
                TextButton(
                    onPressed: (){},
                    child: Text('TextButton')
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text('ElevatedButton')
                )	// 아래는 괄호 파티 시작,,,,,
              ],
            )
          ],
        ),
      ),
    );
  }
}


