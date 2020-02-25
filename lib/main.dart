import 'package:flutter/material.dart';
import 'conta.dart';
import 'dart:convert';
import 'api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

List<Conta> listaConta = List<Conta>();

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        listaConta = list.map((model) => Conta.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de usuários"),
      ),
      body: ListView.builder(
        itemCount: listaConta.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(listaConta[index].login));
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  var login_cont = new TextEditingController();
  var senha_cont = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página Inicial"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: login_cont,
              style: TextStyle(color: Colors.black, fontSize: 18),
              decoration: InputDecoration(labelText: "Login"),
            ),
            TextField(
              controller: senha_cont,
              obscureText: true,
              style: TextStyle(color: Colors.black, fontSize: 18),
              decoration: InputDecoration(labelText: "Senha"),
            ),
            Divider(),
            RaisedButton(
              child: Text("Cadastrar"),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20),
              ),
              onPressed: () {
                listaConta
                    .add(Conta(login: login_cont.text, senha: senha_cont.text));
                senha_cont.clear();
                login_cont.clear();
              },
            ),
            Divider(),
            RaisedButton(
              child: Text("Ver Usuários Cadastrados"),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
