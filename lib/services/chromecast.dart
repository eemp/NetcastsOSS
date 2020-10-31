// Taken from https://github.com/terrabythia/flutter_chromecast_example
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:observable/observable.dart';

class ServiceDiscovery extends ChangeNotifier {

  FlutterMdnsPlugin _flutterMdnsPlugin;
  List<ServiceInfo> foundServices = [];

  ServiceDiscovery() {
    _flutterMdnsPlugin = FlutterMdnsPlugin(
        discoveryCallbacks: DiscoveryCallbacks(
            onDiscoveryStarted: () => {},
            onDiscoveryStopped: () => {},
            onDiscovered: (ServiceInfo serviceInfo) => {},
            onResolved: (ServiceInfo serviceInfo) {
              foundServices.add(serviceInfo);
              notifyChange();
            }
        )
    );

  }

  startDiscovery() {
    _flutterMdnsPlugin.startDiscovery('_googlecast._tcp');
  }

  stopDiscovery() {
    _flutterMdnsPlugin.stopDiscovery();
  }

}
