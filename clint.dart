import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

void main() async {
  // create IP address and port
  final InternetAddress ip = InternetAddress.anyIPv4;
  final int port = 8080;

  // connect to the server
  final Socket server = await Socket.connect(ip, port);
  print("connected to the server");
  server.listen(
    (Uint8List data) async {
      print("new message from server:");
      final response = String.fromCharCodes(data);
      print(response);
    },
    onError: (error) {
      print(error);
      server.destroy();
    },
    onDone: () {
      print('Server left.');
      server.destroy();
      exit(0);
    },
  );

  sendMessageToServer(server);
}

Stream<String?> readMessage() => stdin.transform(utf8.decoder).transform(const LineSplitter());

Future<void> sendMessageToServer(server) async {
  print("Enter a message to send to the server: (type 'exit' to leave)");
  await readMessage().listen((message) async {
    if (message == null) if (message == 'exit') {}
    server.write(message);
  });
}
