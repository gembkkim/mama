import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FileUploadPage(),
    );
  }
}

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({super.key});

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  Dio dio = Dio();

  Future<void> _pickAndUploadFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.any, withData: true);

    if (result != null) {
      List<MultipartFile> files = [];

      for (var file in result.files) {
        debugPrint("@@@@@@@@@@@@@@@@@@@@@@@@@@@ ::: ${file.path}, ${file.name}");
        files.add(await MultipartFile.fromFile(file.path!, filename: file.name));
      }
      debugPrint("1 ${files.length}");
      FormData formData = FormData.fromMap({
        "files": files,
      });

      debugPrint("2");
      String uploadUrl = 'http://10.0.2.2:8080/upload';
      debugPrint(uploadUrl);
      //Response response = await dio.post(uploadUrl, data: formData);
      debugPrint("3");
      try {
        debugPrint("4");
        Response response = await dio.post(
          uploadUrl,
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
        );
        debugPrint("5");
        // Response response = await dio.post(uploadUrl, data: formData);
        debugPrint("Upload success response : ${response.data}");
        debugPrint("6");

        if (response.statusCode == 200) {
          debugPrint("@@@@@@@@@@@@@@@@@@@@@@@@@@@ ::: Files uploaded successfully");
        } else {
          debugPrint("@@@@@@@@@@@@@@@@@@@@@@@@@@@ ::: Failed to upload files");
        }
      } catch (e) {
        debugPrint("@@@@@@@@@@@@@@@@@@@@@@@@@@@ ::: Error uploading files: $e");
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Upload"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickAndUploadFiles,
              child: const Text("Pick and Upload Files"),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const main()),
                // );
               },
              child: const Text("Close"),
            ),
          ],

        )
      ),
    );
  }
}
