import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mama/other.dart';
import 'package:mama/other1.dart';
import 'package:mama/user_list_1.dart';
import 'package:mama/temp/json_parse.dart';
import 'package:mama/camara1.dart';
import 'package:logger/logger.dart';
import 'package:mama/mssql.dart';
import 'package:mama/camera2.dart';
import 'package:mama/file_upload1.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

MSSQL ms = MSSQL();

late List<CameraDescription> _cameras;

Future<void> main() async {
  logger.d('Log message with 2 methods');

  loggerNoStack.i('Info message');

  loggerNoStack.w('Just a warning!');

  logger.e('Error! Something bad happened', error: 'Test Error');

  loggerNoStack.t({'key': 5, 'value': 'something'});

  Logger(printer: SimplePrinter(colors: true)).t('boom');

  // 앱이 실행되기 전에 필요한 초기화 작업을 수행하는 메서드
  // main 함수에서만 호출 가능
  // 사용가능한 카메라를 확인하기 위함
  WidgetsFlutterBinding.ensureInitialized();

  // 사용 가능한 카메라 확인
  _cameras = await availableCameras();

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
          //primarySwatch: Colors.blue,
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
        title: //Image.asset('./images/test.png')
            const Text("Home",
                style: TextStyle(
                  color: Colors.black, //텍스트 색 지정
                  fontSize: 20, //폰트 사이즈
                  fontWeight: FontWeight.normal,
                )),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(

            children: [
              const SizedBox(height: 20),
              const Text("Hello",
                  style: TextStyle(
                    color: Colors.black, //텍스트 색 지정
                    fontSize: 20, //폰트 사이즈
                    fontWeight: FontWeight.normal,
                  ) //텍스트 굵기
                  ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      //MSSQL ms = new MSSQL();
                      ms.connectDbMssql();
                      //페이지 이동
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    },
                    child: const Text("MSSQL-Connect"),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Future<String> sj = ms.selectDbMssql("sp_users_s");
                      sj.then((sj) {
                        //final List<dynamic> dl;
                        debugPrint("main.dart ::: sj = $sj"); //Json Data
                        //Map<String, dynamic> user = jsonDecode(sj);
                      }).catchError((error) {
                        debugPrint('error: $error');
                      });
                      //페이지 이동
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    },
                    child: const Text("select"),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      //MSSQL ms = new MSSQL();
                      //ms.connectDbMssql();
                      ms.affectDbMssql("sp_users_u");
                      //페이지 이동
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => JsonParse()),
                      // );
                    },
                    child: const Text("affect"),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  //페이지 이동
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomePage()),
                  // );
                },
                child: const Text("사용자 목록 페이지 이동"),
              ),
              const SizedBox(width: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  //페이지 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JsonParse()),
                  );
                },
                child: const Text("JSON파싱 샘플 페이지 이동"),
              ),
              const SizedBox(width: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.orangeAccent,
                ),
                onPressed: () {
                  //페이지 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserList1()),
                  );
                },
                child: const Text("UserList1 샘플 페이지 이동"),
              ),
              const SizedBox(width: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87,
                ),
                onPressed: () {
                  //페이지 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CameraApp()),
                  );
                },
                child: const Text("카메라 촬영하기"),
              ),
              const SizedBox(width: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87,
                ),
                onPressed: () {
                  //페이지 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ImageUpload()),
                  );
                },
                child: const Text("사진촬영 갤러리 - 이미지 파일 업로드"),
              ),
              const SizedBox(width: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87,
                ),
                onPressed: () {
                  //페이지 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp2()),
                  );
                },
                child: const Text("일반 파일 업로드"),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OtherPage()),
                  );
                },
                child: const Text("Text button : Other 페이지 호출"),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Other1Page()),
                  );
                },
                child: const Text("Text button : Other1 페이지 호출"),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {
                  //스넥바 호출하는 부분이 새로운 버젼에서 아래와 같이 바뀌었다.
                  //스넥바와 토스트는 비슷한 동작을 한다.
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('My Snack'),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'ACTION',
                      onPressed: () {
                        debugPrint('Snack Bar Action is clicked');
                      },
                    ),
                  ));
                  //print('TextButton is clicked!!!');
                  //print("Button Show me is clicked!!!");
                },
                child: const Text("Text button ::: Snack Bar Action Message"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  debugPrint('Elevated button');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      'My snack bar message',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.grey[600],
                    duration: const Duration(seconds: 3),
                    // 버튼 액션을 넣을때 사용하는 방법
                  ));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey,
                  // button의 모서리 둥근 정도를 바꿀 수 있음
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0.0,
                ),
                child: const Text('Elevated button : Snack Bar Message'),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  debugPrint('Outlined button');
                },
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 3.0,
                    )),
                child: const Text('Outlined button'),
              ),
              const SizedBox(height: 20),
              //4. TextButton에 icon 넣기
              TextButton.icon(
                // 버튼을 비활성화 하는 경우 onPressed 속성에 null값 줌
                onPressed: null,
                icon: const Icon(Icons.home,
                  size: 30.0,
                ),
                label: const Text('Go home'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black54,
                  // 비활성화 된 버튼의 색상을 바꿀때는 disabled- 사용
                  disabledForegroundColor: Colors.pink.withOpacity(0.20),
                  disabledBackgroundColor: Colors.pink.withOpacity(0.20),
                ),
              ),
              const SizedBox(height: 20),
              //5. ButtonBar : 화면에 끝정렬해서 버튼 나타나게 해 줌
              ButtonBar(
                //중앙정렬
                alignment: MainAxisAlignment.center,
                //padding 적용
                buttonPadding: const EdgeInsets.all(20),
                children: [
                  TextButton(
                      onPressed: (){},
                      child: const Text('TextButton')
                  ),
                  ElevatedButton(
                      onPressed: (){},
                      child: const Text('ElevatedButton')
                  )	// 아래는 괄호 파티 시작,,,,,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
