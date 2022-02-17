import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:to_do_app/create.dart';
import 'package:to_do_app/update.dart';

import 'note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  String murl = "http://192.168.0.56:8000/notes";
  _deleteUrl(String id) {
    return "http://192.168.0.56:8000/notes/" + id + "/delete/";
  }

  List<Note> notes = [];

  @override
  void initState() {
    _retrieveNotes();
    super.initState();
  }

  _retrieveNotes() async {
    notes = [];
    List response = json.decode(
        (await client.get(Uri.parse("http://192.168.0.56:8000/notes"))).body);
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    setState(() {});
  }

  void _addNote() {}
  void _deleteNote(String id) {
    client.delete(Uri.parse(_deleteUrl(id)));
    _retrieveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveNotes();
        },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => UpdatePage(
              client: client,
              id: notes[index].id,
              title: notes[index].noteT,
              body: notes[index].noteB,
              ))),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteNote(notes[index].id.toString()),
              ),
              title: Text(
                notes[index].noteT,
              ),
            );
          }, // ItemBuilder
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreatePage(client: client,))),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
