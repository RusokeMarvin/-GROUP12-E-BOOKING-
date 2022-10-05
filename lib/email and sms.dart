import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart'; Unused Dependency
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const SignInScreen(
    title: 'sms',
  ));
}

_sendingMails() async {
  var url = Uri.parse("mailto:dmuhumuza88@gmail.com");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_sendingSMS() async {
  var url = Uri.parse("sms:966738292");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key, required String title}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 200.0,
              ),
              const Text(
                'Welcome to Gmusic app!',
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 20.0,
              ),
              const Text(
                'For any Queries, Mail us',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.green,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: _sendingMails,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.black),
                  ),
                ),
                child: const Text('Here'),
              ), // ElevatedButton

              // DEPRECATED
              // RaisedButton(
              //   onPressed: _sendingMails,
              //   child: Text('Here'),
              //   textColor: Colors.black,
              //   padding: const EdgeInsets.all(5.0),
              // ),
              Container(
                height: 20.0,
              ),
              const Text(
                'Or Send SMS',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.green,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: _sendingSMS,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.black),
                  ),
                ),
                child: const Text('Here'),
              ), // ElevatedButton

              // DEPRECATED
              // RaisedButton(
              //   onPressed: _sendingSMS,
              //   textColor: Colors.black,
              //   padding: const EdgeInsets.all(5.0),
              //   child: Text('Here'),
              // ), child: const Text('Here'),
            ],
          ),
        ),
      ),
    );
  }
}
