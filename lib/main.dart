import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:async/async.dart";
import "dart:convert";

const request = "https://api.hgbrasil.com/finance?key=b3549cf3";

void main() {
  runApp(MaterialApp(
    home: Home(),
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
                  if (snapshot.hasError) {
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
                            Icon(Icons.monetization_on, size: 150,
                                color: Colors.amberAccent),
                            TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Reais",
                                labelStyle: TextStyle(
                                  color: Colors.amberAccent,
                                ),
                                border: OutlineInputBorder(),
                                prefixText: "R\$"
                              ),
                            )
                          ],
                        )
                    );
                  }
              }
            }));
  }
}
