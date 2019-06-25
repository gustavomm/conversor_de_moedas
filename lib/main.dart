import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:async/async.dart";
import "dart:convert";

const request = "https://api.hgbrasil.com/finance?key=b3549cf3";

void main() {
  runApp(MaterialApp(home: Home(),));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
