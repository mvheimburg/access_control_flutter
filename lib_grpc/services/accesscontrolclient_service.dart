import 'package:grpc/grpc.dart';

import 'package:access_control_flutter/model/accesscontrol.pb.dart';
import 'package:access_control_flutter/model/accesscontrol.pbgrpc.dart';

class AccessControlClientService {
  static AccessControlClient stub;
  static ClientChannel channel;

  AccessControlService(String name) {
    channel = ClientChannel("127.0.0.1",
        port: 5055,
        options: ChannelOptions(credentials: ChannelCredentials.insecure()));

    stub = AccessControlClient(channel,
        options: CallOptions(timeout: Duration(seconds: 30)));
  }

  // @override
  // Future<DingDongReply> dingDong(String message) async {
  //   return stub.dingDong(DingDongRequest().message = 'balle');
  // }
}
