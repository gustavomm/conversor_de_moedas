import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:async/async.dart";
import "dart:convert";

const request = "https://api.hgbrasil.com/finance?key=b3549cf3";

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      primaryColor: Colors.amberAccent,
      hintColor: Colors.amberAccent
    )
  ));
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
  double dolar;
  double euro;

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  void _realChanged(String text){
    print(text);
  }

  void _dolarChanged(String text){
    print(text);
  }

  void _euroChanged(String text){
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("\$ Conversor de Moedas \$"),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        backgroundColor: Colors.black12,
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Text("Carregando Dados...",
                        style: TextStyle(color: Colors.white70, fontSize: 25),
                        textAlign: TextAlign.center),
                  );
                default:
                  print(snapshot.data);
                  if (snapshot.hasError || snapshot.data["results"]["currencies"] == null) {
                    return Center(
                      child: Text("Erro ao Carregar Dados :(",
                          style: TextStyle(color: Colors.white70, fontSize: 25),
                          textAlign: TextAlign.center),
                    );
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    return SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on,
                            size: 150, color: Colors.amberAccent),
                        buildTextField("Reais", "R\$", realController, _realChanged),
                        Divider(),
                        buildTextField("Dólares", "R\$", dolarController, _dolarChanged),
                        Divider(),
                        buildTextField("Euros", "€", euroController, _euroChanged),
                      ],
                    ));
                  }
              }
            }));
  }
}

Widget buildTextField(String label, String prefix, TextEditingController c, Function f) {
  return TextField(
      controller: c,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.amberAccent,
          ),
          border: OutlineInputBorder(),
          prefixText: prefix),
      style: TextStyle(
          color: Colors.white70,
          fontSize: 20
      ),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}