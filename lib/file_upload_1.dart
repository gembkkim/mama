import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class FileUpload1 extends StatefulWidget {
  @override
  _FileUpload1State createState() => _FileUpload1State();
}

class _FileUpload1State extends State<FileUpload1> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null) {
      setState(() {
        _imageFiles = selectedImages;
      });
    }
  }

  Future<void> _uploadFiles() async {
    if (_imageFiles == null || _imageFiles!.isEmpty) {
      print("No images selected.");
      return;
    }

    try {
      Dio dio = Dio();
      String uploadUrl = 'http://localhost:8080/upload';

      List<MultipartFile> multipartFiles = _imageFiles!.map((file) async {
        return MultipartFile.fromFile(file.path, filename: file.name);
      }).toList();

      FormData formData = FormData.fromMap({
        'files': await Future.wait(multipartFiles),
      });

      Response response = await dio.post(uploadUrl, data: formData);
      print("Upload response: ${response.data}");
    } catch (e) {
      print("Upload failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Pick Images'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFiles,
              child: Text('Upload Files'),
            ),
            SizedBox(height: 20),
            _imageFiles != null
                ? Wrap(
              spacing: 10,
              children: _imageFiles!.map((file) {
                return Image.file(
                  File(file.path),
                  width: 100,
                  height: 100,
                );
              }).toList(),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: FileUpload1()));
