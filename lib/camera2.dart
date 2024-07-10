import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => ImageUploadState();
}

final picker = ImagePicker();
XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

class ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text('업로드를 실행하기 위해서는 터미널에서 Dart Server 를 실행한 후 테스트하시길 바랍니다.'),
                const SizedBox(
                  height: 20,
                ),
                const Text('PS D:\\flutterapp\\mama> cd dart-server',
                  style: TextStyle(color: Colors.blue),),
                const Text('PS D:\\flutterapp\\mama\\dart-server> dart run bin\\server.dart',
                  style: TextStyle(color: Colors.blue),),
                const Text('Server listening on port 8080',
                  style: TextStyle(color: Colors.redAccent),),
                const SizedBox(
                  height: 20,
                ),
                const Text('위와 같이 나타나면 Dart-Server 실행완료된 것 입니다.'),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //카메라로 촬영하기
                    Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 5)
                          ],
                        ),
                        child: IconButton(
                            onPressed: () async {
                              image = await picker.pickImage(
                                  source: ImageSource.camera);
                              //카메라로 촬영하지 않고 뒤로가기 버튼을 누를 경우, null값이 저장되므로 if문을 통해 null이 아닐 경우에만 images변수로 저장하도록 합니다
                              if (image != null) {
                                setState(() {
                                  images.add(image);
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 30,
                              color: Colors.white,
                            ))),
                    //갤러리에서 가져오기
                    Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 5)
                          ],
                        ),
                        child: IconButton(
                            onPressed: () async {
                              multiImage = await picker.pickMultiImage();
                              setState(() {
                                //갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                                images.addAll(multiImage);
                              });
                            },
                            icon: const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 30,
                              color: Colors.white,
                            ))),
                    //파일 업로드(김봉균 추가)
                    Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 5)
                          ],
                        ),
                        child: IconButton(
                            onPressed: () async {
                              //multiImage = await picker.pickMultiImage();
                              setState(() {
                                //갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                                //images.addAll(multiImage);
                                FileUpload1().uploadFiles();
                              });

                              debugPrint('File Upload');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  '파일이 업로드 되었습니다.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                backgroundColor: Colors.orangeAccent,
                                duration: Duration(seconds: 3),
                                // 버튼 액션을 넣을때 사용하는 방법
                              ));
                            },
                            icon: const Icon(
                              //Icons.add_photo_alternate_outlined,
                              Icons.file_upload,
                              size: 30,
                              color: Colors.white,
                            )))
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: images.length,
                    //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //1 개의 행에 보여줄 사진 개수
                      childAspectRatio: 1 / 1, //사진 의 가로 세로의 비율
                      mainAxisSpacing: 10, //수평 Padding
                      crossAxisSpacing: 10, //수직 Padding
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover, //사진을 크기를 상자 크기에 맞게 조절
                                    image: FileImage(File(images[index]!
                                            .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                        )))),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              //삭제 버튼
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(Icons.close,
                                    color: Colors.white, size: 15),
                                onPressed: () {
                                  //버튼을 누르면 해당 이미지가 삭제됨
                                  setState(() {
                                    images.remove(images[index]);
                                  });
                                },
                              ))
                        ],
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}

class FileUpload1 {
  //_FileUpload1State createState() => _FileUpload1State();
  // final ImagePicker _picker = ImagePicker(); //picker
  // List<XFile>? _imageFiles; //images
  // final picker = ImagePicker();
  // XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
  // List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
  // List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

  Future<void> uploadFiles() async {
    // final List<XFile>? selectedImages = await picker.pickMultiImage();
    // if (selectedImages != null) {
    //   setState(() {
    //     images = selectedImages;
    //   });
    // }
    if (images.isEmpty) {
      debugPrint("선택된 이미지가 없습니다.");
      return;
    } else {
      debugPrint("${images.length.toString()} 개의 이미지가 선택 되었습니다.");
    }

    try {
      Dio dio = Dio();
      String uploadUrl = 'http://10.0.2.2:8080/upload';

      Iterable<Future<MultipartFile>> multipartFiles = images.map((file) async {
        return MultipartFile.fromFile(file!.path, filename: file.name);
      });

      FormData formData = FormData.fromMap({
        'files': await Future.wait(multipartFiles),
      });

      Response response = await dio.post(uploadUrl, data: formData);
      debugPrint("Upload success response : ${response.data}");
    } catch (e) {
      debugPrint("Upload fail error : $e");
    }
  }
}
