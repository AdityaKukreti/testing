import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({required this.server});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late BluetoothConnection connection;
  List<String> messages = [];
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      setState(() {
        connection = _connection;
      });
      connection.input?.listen((data) {
        setState(() {
          messages.add(String.fromCharCodes(data));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.server.name}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          ListTile(
            title: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Message',
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.send),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (textController.text.isNotEmpty) {
      connection.output.add(utf8.encode(textController.text + "\r\n"));
      setState(() {
        messages.add(textController.text);
        textController.clear();
      });
    }
  }

  @override
  void dispose() {
    connection?.dispose();
    super.dispose();
  }
}
