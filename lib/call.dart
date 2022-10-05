import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Call extends StatefulWidget {
  const Call({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        body: Center(child: buildButton()),
      );
  Widget buildButton() {
    const number = '+256773078427';
    return ListTile(
      title: const Text('David'),
      subtitle: const Text(number),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(''),
      ),
      trailing: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue),
          ),
        ),
        child: const Text('Call'),
        onPressed: () async {
          //indirect
          launchUrlString('tel://$number');
          // direct
        },
      ),
    );
  }
}
