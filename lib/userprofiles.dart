import 'package:bounce/profilewidget.dart';
import 'package:flutter/material.dart';
import 'package:bounce/category.dart';
import 'package:bounce/search.dart';
import 'package:bounce/login_page.dart';
import 'package:bounce/user.dart';
import 'package:bounce/user_preferences.dart';
import 'package:bounce/userprofiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'NavBar.dart';
import 'buttonwidget.dart';
import 'numbers_widget';

_launchURLBrowser() async {
  var url = Uri.parse("https://paystack.com/pay/hob");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
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
  var url = Uri.parse("sms:+256773078427");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class ProfilePage extends StatelessWidget {
  final User user;
  ProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    const number = '+256773078427';
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {},
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(user.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          ),
          Center(
            child: Text(
              user.email,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 80),
              IconButton(
                icon: Icon(Icons.message, color: Colors.blue),
                onPressed: _sendingSMS,
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: Icon(Icons.phone, color: Colors.blue),
                onPressed: () async {
                  //indirect
                  launchUrlString('tel://$number');
                  // direct
                },
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: Icon(Icons.email, color: Colors.blue),
                onPressed: _sendingMails,
              ),
            ],
          ),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  user.about,
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildUpgradeButton() => ButtonWidget(
      text: 'BOOK ARTIST',
      onClicked: _launchURLBrowser,
    );
