import 'dart:io';
import 'dart:async';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart' as shelf_ws;
import 'package:web_socket_channel/web_socket_channel.dart';

void main(List<String> arguments) async {
  final app = Router()
    ..get('/rest', handleHttpRequest)
    ..get('/ws', shelf_ws.webSocketHandler(handleWebSocketConnect));

  final port = Platform.environment['PORT'];
  final server = await shelf_io.serve(
    app,
    '0.0.0.0',
    port == null ? 8080 : int.parse(port),
  );

  print('Listening on :${server.port}');
}

Future<Response> handleHttpRequest(Request request) async {
  // TODO: Handle HTTP requests

  return Response.ok('Hello, World!');
}

void handleWebSocketConnect(WebSocketChannel socket) {
  // TODO: Handle WebSocket connections

  print('WebSocket client connected');
  socket.stream.listen(print);
}
