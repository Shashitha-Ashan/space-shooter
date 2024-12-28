import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameSocket {
  late IO.Socket socket;

  void connect() {
    socket = IO.io(
      'http://10.0.2.2:3000',
      IO.OptionBuilder()
          .setTransports(['websocket']) // For Flutter or Dart VM
          .enableAutoConnect()
          .build(),
    );

    socket.onConnect((_) {
      print('Connected to server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from server');
    });

    socket.on('roomCreated', (roomName) {
      print('Room created: $roomName');
    });

    socket.on('updateAction', (data) {
      print('Action update: $data');
    });

    socket.on('error', (error) {
      print('Error: $error');
    });
    socket.on('updatePosition', (position) {
      print(position);
    });
  }

  void createRoom(String roomName, String password) {
    socket.emit('createRoom', {'roomName': roomName, 'password': password});
  }

  void joinRoom(String roomName, String password) {
    socket.emit('joinRoom', {'roomName': roomName, 'password': password});
  }

  void sendAction(String roomName, Map<String, dynamic> action) {
    socket.emit('playerAction', {'roomName': roomName, 'action': action});
  }

  void sendPostion(String roomName, Map<String, dynamic> position) {
    socket.emit('playerPosition', {'roomName': roomName, 'position': position});
  }
}
