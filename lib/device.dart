import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends ListTile {
  final BluetoothDevice device;
  final VoidCallback onTap;

  BluetoothDeviceListEntry({required this.device, required this.onTap})
      : super(
          title: Text(device.name ?? "Unknown device"),
          subtitle: Text(device.address.toString()),
          trailing: Icon(Icons.chevron_right),
          onTap: onTap,
        );
}
