import 'dart:io';
import 'dart:typed_data';

// List of clint
List<Socket> clients = [];

void main() async {
  /// create IP address and port
  final InternetAddress ip = InternetAddress.anyIPv4;
  final int port = 8080;

  // create server socket
  final server = await ServerSocket.bind(ip, port);
  print("server is running on ${ip.address}:$port");

  // listen to incoming connections
  server.listen((Socket socket) {
    print("new connection from ${socket.remotePort}");
    socket.write("You are connected to the server");
    clients.add(socket);
    handelClintConnection(socket);
  });
}

void handelClintConnection(Socket client) async {
  // listen to incoming data
  client.listen(
    (Uint8List data) async {
      final String message = String.fromCharCodes(data);
      print("message from client:${client.remotePort} => $message");
      // SocketCommand command = parseCommand(message);

      // send the message to all clients
      for (final c in clients) {
        print("send message to client:${c.remotePort}");
        c.write("Sender:${c.remotePort} =>  $message");
      }
    },
    onDone: () {
      print("connection left the server");
      client.close();
    },
    onError: (e) {
      print("some error occurred");
      client.close();
    },
  );
}
