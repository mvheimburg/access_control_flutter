import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new AccessControlApp());

class AccessControlApp extends StatefulWidget {
  _AccessControlAppState createState() => _AccessControlAppState();
}

class _AccessControlAppState extends State<AccessControlApp> {
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

    final response = await http.get(
        'https://homeassistant.local:8123/hassio/local_access_control/resources/data/all');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var ret = jsonDecode(response.body);
      print(ret);
      print(ret[0]['mac']);
      setState(() {
        res = ret[0]['mac'].toString();
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    // setState(() {
    //   res = response;
    // });

    // var ret = await DingDongService.DingDong();
    // print('Greeter client received: ${ret.message}');
  }
}
