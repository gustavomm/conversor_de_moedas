import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:async/async.dart";
import "dart:convert";

const request = "https://api.hgbrasil.com/finance?key=b3549cf3";

void main() async{

  http.Response response = await http.get(request);

  print(json.decode(response.body)["results"]["currencies"]);

  runApp(MaterialApp(home: Home(),));
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
