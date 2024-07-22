import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'device.dart'; // This contains the ChatPage definition

class SelectBondedDevicePage extends StatefulWidget {
  final bool checkAvailability;
  final Function(BluetoothDevice) onChatPage;

  const SelectBondedDevicePage(
      {this.checkAvailability = true, required this.onChatPage});

  @override
  _SelectBondedDevicePageState createState() => _SelectBondedDevicePageState();
}

class _SelectBondedDevicePageState extends State<SelectBondedDevicePage> {
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Device')),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return BluetoothDeviceListEntry(
            device: devices[index],
            onTap: () => widget.onChatPage(devices[index]),
          );
        },
      ),
    );
  }
}
