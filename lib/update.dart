import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String title;
  final String body;
  const UpdatePage({
    Key? key,
    required this.client, required this.id, required this.title, required this.body,
  }) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controllerForTitle = TextEditingController();
  TextEditingController controllerForBody = TextEditingController();

initState() {
  controllerForTitle.text = widget.title;
  controllerForBody.text = widget.body;
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Note"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controllerForTitle,
            maxLines: 2,
          ),
          TextField(
            controller: controllerForBody,
            maxLines: 10,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.put(
                    Uri.parse("http://192.168.0.56:8000/notes/" + widget.id.toString() + "/update/"),
                    body: {
                      'title': controllerForTitle.text,
                      'body': controllerForBody.text
                    });
                Navigator.pop(context);
              },
              child: Text("Update Note")),
        ],
      ),
    );
  }
}
