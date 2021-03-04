import 'package:flutter/material.dart';
import 'package:grpc/grpc_web.dart';
import 'package:access_control_flutter/services/accesscontrolclient_service.dart';
import 'package:access_control_flutter/model/accesscontrol.pb.dart';
import 'package:access_control_flutter/model/accesscontrol.pbgrpc.dart';

void main() => runApp(new FlutterGrpcApp());

class FlutterGrpcApp extends StatefulWidget {
  _FlutterGrpcAppState createState() => _FlutterGrpcAppState();
}

class _FlutterGrpcAppState extends State<FlutterGrpcApp> {
  String res;

  @override
  void initState() {
    res = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Grpc ❤️ Flutter"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  onPressed: () async => _dingDong(),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Let's say hi!",
                    style: TextStyle(color: Colors.white),
                  )),
              res.isNotEmpty ? Text("Server says: $res") : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dingDong() async {
    print("prover dingdong");
    final channel =
        GrpcWebClientChannel.xhr(Uri.parse('http://127.0.0.1:5055'));

    // final channel = ClientChannel(
    //   '127.0.0.1',
    //   port: 5055,
    //   options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    // );

    final stub = AccessControlClient(channel);

    try {
      print("prover virkelig dingdong");

      // final testmessage = "hei fra flutter";
      // var response =
      //     await stub.dingDong(DingDongRequest()..message = testmessage);

      final request = DingDongRequest()..message = "testing flutter";
      print('laget request: ${request.message}');
      var response = await stub.dingDong(request);

      print('Greeter client received: ${response.message}');

      setState(() {
        res = response.message;
      });
    } catch (e) {
      print('Caught error: $e');
    }
    await channel.shutdown();

    // var ret = await DingDongService.DingDong();
    // print('Greeter client received: ${ret.message}');
  }
}
