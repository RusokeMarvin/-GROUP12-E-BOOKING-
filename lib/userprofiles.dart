import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounce/user.dart';
import 'package:bounce/user_preferences.dart';
import 'package:bounce/buttonwidget.dart';
import 'package:bounce/numbers_widget';
import 'package:bounce/profilewidget.dart';
import 'package:bounce/edit_profile_page.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();
    const number = '+256773078427';

    return Scaffold(
      appBar: AppBar(
        title: Text('USER PROFILE'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
              setState(() {});
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
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
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'BOOK ARTIST',
        onClicked: _launchURLBrowser,
      );

  Widget buildAbout(User user) => Container(
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
      );
}
