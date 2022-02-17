import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controllerForTitle = TextEditingController();
  TextEditingController controllerForBody = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
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
          ElevatedButton(onPressed: () {
            widget.client.post(Uri.parse("http://192.168.0.56:8000/note/create/"), body: {'title': controllerForTitle.text, 'body':controllerForBody.text});
            Navigator.pop(context);
          }, child: Text("Create Note")),
        ],
      ),
    );
  }
}