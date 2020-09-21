// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';


// void main() => runApp(MyApp());


// This example app is only one page
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: PegProgressIndicator(),
      ),
    ),
  );
}

// This widget is the progress indicator container
class PegProgressIndicator extends StatefulWidget {
  @override
  _PegProgressIndicatorState createState() => _PegProgressIndicatorState();
}


class _PegProgressIndicatorState extends State<PegProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text('Hello World'),
             Text('Hello Hass')
          ],
        ),
      ),
    );
  }
}