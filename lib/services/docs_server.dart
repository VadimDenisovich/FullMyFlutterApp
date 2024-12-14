import 'dart:io';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

/// Запустить командой 'dart run lib/services/docs_server.dart'
void main() async {
  final handler = createStaticHandler(
    'doc/api',
    defaultDocument: 'index.html',
  );

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Сервер запущен по адресу http://localhost:8080');
}
