// taken from https://github.com/terrabythia/flutter_chromecast_example
import 'dart:async';
import 'dart:convert' show utf8;

import 'package:dart_chromecast/casting/cast_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/services/chromecast.dart';
import 'package:observable/observable.dart';

class DevicePicker extends StatefulWidget {

  final Function(CastDevice) onDevicePicked;

  DevicePicker({ this.onDevicePicked });

  @override
  _DevicePickerState createState() => _DevicePickerState();

}

class _DevicePickerState extends State<DevicePicker> {

  final App app = App();
  List<CastDevice> _devices = [];
  List<StreamSubscription> _streamSubscriptions = [];

  void initState() {
    super.initState();
    app.serviceDiscovery.changes.listen((List<ChangeRecord> _) {
      _updateDevices();
    });
    _updateDevices();
  }

  _deviceDidUpdate(CastDevice device) {
    // this device did update, we need to trigger setState
    setState(() => {});
  }

  CastDevice _deviceByName(String name) {
    return _devices.firstWhere((CastDevice d) => d.name == name, orElse: () => null);
  }

  CastDevice _castDeviceFromServiceInfo(ServiceInfo serviceInfo) {
    CastDevice castDevice = CastDevice(
      attr: serviceInfo.attr,
      name: serviceInfo.name,
      type: serviceInfo.type,
      host: serviceInfo.hostName,
      port: serviceInfo.port
    );
    _streamSubscriptions.add(
        castDevice.changes.listen((_) => _deviceDidUpdate(castDevice))
    );
    return castDevice;
  }

  _updateDevices() {
    // probably a new service was discovered, so add the new device to the list.
    _devices = app.serviceDiscovery.foundServices
      .fold(<String, CastDevice>{}, (uniqMap, serviceInfo) {
        if(uniqMap[serviceInfo.name] == null) {
          uniqMap[serviceInfo.name] = _castDeviceFromServiceInfo(serviceInfo);
        }
        return uniqMap;
      })
      .values
      .toList();
  }

  Widget _buildListViewItem(BuildContext context, int index) {
    Map<String, Icon> icons = <String, Icon>{
      'Google Home': const Icon(Icons.home),
      'Google Home Mini': const Icon(Icons.speaker),
      'default': const Icon(Icons.cast),
    };
    CastDevice castDevice = _devices[index];
    return ListTile(
      leading: icons[castDevice.modelName] ?? icons['default'],
      title: Text(castDevice.friendlyName),
      onTap: () {
        if (null != widget.onDevicePicked) {
          widget.onDevicePicked(castDevice);
          // clean up steam listeners
          _streamSubscriptions.forEach((StreamSubscription subscription) => subscription.cancel());
          Navigator.of(context).pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Device'),
      ),
      body: Container(
        child: ListView.builder(
          key: Key('devices-list'),
          itemBuilder: _buildListViewItem,
          itemCount: _devices.length,
        ),
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}
