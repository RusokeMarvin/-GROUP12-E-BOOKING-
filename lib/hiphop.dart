import 'package:flutter/material.dart';
import 'package:bounce/homefinal.dart';
import 'package:bounce/search.dart';
import 'package:bounce/login_page.dart';
import 'package:bounce/user.dart';
import 'package:bounce/user_preferences.dart';
import 'package:bounce/userprofiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'NavBar.dart';

class HipHop extends StatefulWidget {
  HipHop(this.colorVal);
  int colorVal;

  @override
  State<HipHop> createState() => _HipHopState();
}

class _HipHopState extends State<HipHop> {
  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.imagePath)),
        title: Text(user.name),
        subtitle: Text(user.email.toString()),
      );
  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection("Hip-Hop")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;

              return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: ListView(
                    children: users.map(buildUser).toList(),
                  ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
