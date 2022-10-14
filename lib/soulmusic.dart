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
import 'NavBar.dart';

class SoulMusic extends StatefulWidget {
  SoulMusic(this.colorVal);
  int colorVal;

  @override
  State<SoulMusic> createState() => _SoulMusicState();
}

class _SoulMusicState extends State<SoulMusic> {
  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.imagePath)),
        title: Text(user.name),
        subtitle: Text(user.email.toString()),
      );
  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection("Soul Music")
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

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data![index].imagePath),
                    ),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].email),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(snapshot.data![index])));
                    },
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
