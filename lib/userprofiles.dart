import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounce/user.dart';
import 'package:bounce/user_preferences.dart';
import 'package:bounce/buttonwidget.dart';
import 'package:bounce/numbers_widget';
import 'package:bounce/profilewidget.dart';
import 'package:bounce/edit_profile_page.dart';
import 'package:bounce/call.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        actions: [
          IconButton(
              icon: Icon(Icons.logout, color: Colors.white), onPressed: () {}),
        ],
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
              const SizedBox(width: 120),
              IconButton(
                  icon: Icon(Icons.message, color: Colors.blue),
                  onPressed: () {}),
              const SizedBox(width: 30),
              IconButton(
                icon: Icon(Icons.phone, color: Colors.blue),
                onPressed: () async {
                  //indirect
                  launchUrlString('tel://$number');
                  // direct
                },
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
        onClicked: () {},
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
