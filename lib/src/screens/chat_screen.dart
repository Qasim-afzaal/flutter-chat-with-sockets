import 'dart:async';

import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_chat/src/components/chat_shimmer.dart';
import 'package:flutter_chat/src/model/get_all_chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:watch_it/watch_it.dart';


// final ChatController _chatController = di<ChatController>();

class ChatScreen extends StatefulWidget
    // with WatchItStatefulWidgetMixin 
    {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GetAllChat? getAllChat;
  bool _isLoading = true;
  List<Conversation> messagesList = [];

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _initializeSocket();
    getChat();
    _startConnectivityListener();
    _initializeSocketEvents();
  }

  void _initializeSocket() {
    print('Initializing socket...');
    final url =
        'http://.............?user_id="add user id"&conversation_id="add conversation id';
    socket = IO.io(url, <String, dynamic>{
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

    socket.on('message', (data) {
      print('Received message: $data');
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket');
    });

    socket.connect();
  }
// you can use user data if you want our requirment is this thats why i used
  void getChat() {
    final messageData = {
      "user_id": "_user.userID",
      "conversation_id": "_chatController.conversationId.value",
      "page": 1,
      "size": 100
    };

    print('getConversationDetail: $messageData');
    socket.emit('getConversationDetail', messageData);
    socket.on('chats', (data) {
      print('chat event: $messageData');
      getAllChat = GetAllChat.fromJson(data);
      setState(() {
        _isLoading = false;
        _scrollToBottom();
      });
    });
  }

  void sendMessage(String content) {
    final messageData = {
      "sender_id": "_user.userID",
      "message": content,
      "conversation_id": "_chatController.conversationId.value",
    };

    print('sendMessasge: $messageData');
    socket.emit('sendMessage', messageData);
    socket.on('receiveMessage', (data) {
      print('${data}');
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _initializeSocketEvents() {
    socket.on('receiveMessage', (data) {
      print('${data}');
      setState(() {
        getAllChat!.conversation
            .add(Conversation.fromJson(data["savedMessage"]));
        print(getAllChat!.conversation.length);
        _scrollToBottom();
      });
    });
  }

  void _startConnectivityListener() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print('Connectivity changed: $result');
      if (result == ConnectivityResult.none) {
        print('No internet connection');
        if (socket.connected) {
          socket.disconnect();
        }
      } else {
        print('Internet connection available');
        if (!socket.connected) {
          _initializeSocket();
        }
      }
    });
  }

  @override
  void dispose() {
    socket.dispose();
    _connectivitySubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
appBar: AppBar(
  centerTitle: true,
  title: Text("CHAT WITH SOCKET IO"),
),
              body:      _isLoading
          ? const ChatShimmer()
          : GestureDetector(
                onTap: (){
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Column(
                  children: [
                    Expanded(
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          itemCount: getAllChat!.conversation.length,
                          itemBuilder: (context, index) {
                            final message = getAllChat!.conversation[index];
                            final timestamp = message.createdAt;
                            final isSender = message.senderId == "_user.userID";
                
                            return Align(
                              alignment: isSender
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: isSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!isSender)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[200],
                                        radius: 16,
                                        backgroundImage: NetworkImage(
                                            message.user.profileImageUrl),
                                      ),
                                    ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5.0),
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: isSender
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (!isSender)
                                          Text(
                                            '${message.user.firstname} ${message.user.lastname}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isSender
                                                  ? Colors.white
                                                  : theme.colorScheme.onSurface,
                                            ),
                                          ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: isSender
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                message.content,
                                                style: TextStyle(
                                                  color: isSender
                                                      ? Colors.white
                                                      : theme
                                                          .colorScheme.onSurface,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "timestamp",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: isSender
                                                ? Colors.white
                                                : theme.colorScheme.onSurface
                                                    .withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSender)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[200],
                                        radius: 16,
                                        backgroundImage: NetworkImage(
                                            message.user.profileImageUrl),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 26),
                      child: TextFormField(
                        controller: _messageController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.background,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (_messageController.text.isNotEmpty) {
                                sendMessage(_messageController.text);
                                _messageController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
  }

  Widget buildSharedUsersRow() {
    return Row(
      children: List.generate(
        getAllChat!.sharedUsers.length,
        (index) => CircleAvatar(
          backgroundColor: Colors.grey[200],
          radius: 14,
          backgroundImage:
              NetworkImage(getAllChat!.sharedUsers[index].profileImageUrl),
        ),
      ),
    );
  }
}
