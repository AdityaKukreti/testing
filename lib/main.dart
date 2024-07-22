import 'package:flutter/material.dart';

import 'connection.dart';
import 'led.dart'; // Assuming your connection.dart manages Bluetooth connections

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SelectBondedDevicePage(
        checkAvailability: true,
        onChatPage: (device) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(server: device),
            ),
          );
        },
      ),
    );
  }
}
