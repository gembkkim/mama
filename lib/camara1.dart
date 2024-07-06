import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

late List<CameraDescription> _cameras;

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => CameraAppState();
}

class CameraAppState extends State<CameraApp> {
  // 카메라 컨트롤러 인스턴스 생성
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    // 카메라 컨트롤러 초기화
    // _cameras[0] : 사용 가능한 카메라
    controller =
        CameraController(_cameras[0], ResolutionPreset.max, enableAudio: false);

    controller.initialize().then((_) {
      // 카메라가 작동되지 않을 경우
      if (!mounted) {
        return;
      }
      // 카메라가 작동될 경우
      setState(() {
        // 코드 작성
      });
    })
    // 카메라 오류 시
        .catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("CameraController Error : CameraAccessDenied");
            // Handle access errors here.
            break;
          default:
            print("CameraController Error");
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    // 카메라 컨트롤러 해제
    // dispose에서 카메라 컨트롤러를 해제하지 않으면 에러 가능성 존재
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 카메라 컨트롤러가 초기화 되어 있지 않을 경우, 카메라 뷰 띄우지 않음
    if (!controller.value.isInitialized) {
      return Container();
    }
    // 카메라 촬영 화면
    return CameraPreview(controller);
  }
}