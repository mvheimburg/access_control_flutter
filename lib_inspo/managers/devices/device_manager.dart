import 'package:upnp/upnp.dart';

class DeviceManager {
  static final defaultManager = DeviceManager();
  StateSubscriptionManager globalSub;
  List<StateSubscriptionManager> individualSubs = [];

  Future<List<Device>> getMonitorDevices() async {
    // List<Device> listOfAccessControlDevices = [];
    var disc = new DeviceDiscoverer();
    await disc.start(ipv6: false);

    var listOfAccessControlDevices =
        disc.getDevices(type: "urn:access-control:service:1");
    return listOfAccessControlDevices;
  }
}
