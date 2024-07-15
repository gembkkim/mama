import 'dart:developer';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..post('/upload', _uploadHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> _uploadHandler(Request request) async {
  if (!request.isMultipart) {
    return Response.badRequest(body: 'bad request 400');
  }

  var serverFileName = '';
  var serverFileNames = '';
  var fileCount = 0;

  await for (final part in request.parts) {
    fileCount++;

    print("Multipart File Uploading ...");
    log("Multipart File Uploading ...");
    final headers = part.headers['content-disposition'] ?? '';
    print("Multipart File Uploading ::: headers = $headers");
    log("Multipart File Uploading ::: headers = $headers");
    var clientFileName = part.headers['content-disposition'].toString().split('filename=')[1].split(';')[0].replaceAll('"', '');
    print("Multipart File Uploading ::: clientFileName = $clientFileName");
    log("Multipart File Uploading ::: clientFileName = $clientFileName");
    //클라이언트파일을 서버에 저장을 하기 위한 폴더규칙 및 중복파일이 있는지 체크하여 넘버링을 하든지 조치하여야 함.
    //현재는 클라이언트 파일명을 그대로 사용을 하였음.
    serverFileName = clientFileName;
    print("Multipart File Uploading ::: serverFileName = $serverFileName");
    log("Multipart File Uploading ::: serverFileName = $serverFileName");

    //filename1 = filename.split('-')[4].toString()
    //final filename1 = part.headers['filename'] ?? '';
    //List<String> filename = filename1.split('-');
    //print(filename1.split('-')[4].toString());
    if(headers.contains('name="files"') || headers.contains('name="file"') || headers.contains('name="multipart/form-data"')){
      final content = await part.readBytes();
      //File file = await File('static/${filename1.toString()}').create();
      File file = await File('static/$serverFileName').create();
      file.writeAsBytesSync(content);
    }
    print("Multipart File Uploading ::: Server File Path = static/$serverFileName");
    log("Multipart File Uploading ::: Server File Path = static/$serverFileName");

    serverFileNames = "${serverFileNames}File $fileCount : static/$serverFileName\n";
  }
  return Response.ok('$serverFileNames');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
