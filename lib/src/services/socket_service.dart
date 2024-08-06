import 'package:flutter_chat/src/model/get_all_chat.dart';
import 'package:flutter_chat/src/model/property_chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketService {
  SocketService._();

  static SocketService get instance => SocketService._();


  PropertyChatModel? _propertyChatModel;
  GetAllChat? _getAllChat;
  String? _id;

  PropertyChatModel? get propertyChatModel => _propertyChatModel;
  GetAllChat? get getAllChat => _getAllChat;
  String? get id => _id;

  late IO.Socket socket;

  void initializeSocket() {
    print('Initializing socket...');
    socket = IO.io('http://34.29.1.49:3004', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected to socket');
    });

    socket.onConnectError((error) {
      print('Connection error: $error');
    });

    socket.onConnectTimeout((_) {
      print('Connection timeout');
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket');
    });

    socket.connect();
  }

  void getChat(Map<String, dynamic> messageData, Function onChatReceived) {
    print('getConversationDetail: $messageData');
    socket.emit('getConversationDetail', messageData);
    socket.on('chats', (data) {
      print('chat event: $messageData');
      onChatReceived(data);
    });
  }

  void sendMessage(Map<String, dynamic> messageData, Function onMessageSent) {
    print('sendMessage: $messageData');
    socket.emit('sendMessage', messageData);
    socket.on('receiveMessage', (data) {
      print('receiveMessage: $data');
      onMessageSent(data);
    });
  }

  void dispose() {
    socket.dispose();
  }

}
