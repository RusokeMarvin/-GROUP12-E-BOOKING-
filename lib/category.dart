import 'package:bounce/hiphop.dart';
import 'package:bounce/search.dart';
import 'package:bounce/soulmusic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'NavBar.dart';
import 'afrobeat.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

Color PrimaryColor = Color(0xff109618);

class _homeState extends State<home> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          drawer: Editnav(),
          appBar: AppBar(
            backgroundColor: PrimaryColor,
            title: Text('E-BOOKING APP'),
            actions: [
              IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Search()));
                  }),
              IconButton(
                  icon: Icon(Icons.logout, color: Colors.white),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  }),
            ],
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 6.0,
              onTap: (index) {
                setState(() {
                  switch (index) {
                    case 0:
                      PrimaryColor = Color(0xff2196f3);
                      break;
                    case 1:
                      PrimaryColor = Color(0xff3f51b5);
                      break;
                    case 2:
                      PrimaryColor = Color(0xffe91e63);
                      break;
                    case 3:
                      PrimaryColor = Color(0xff9c27b0);
                      break;
                    case 4:
                      PrimaryColor = Color(0xffff5722);
                      break;
                    default:
                  }
                });
              },
              tabs: <Widget>[
                Tab(
                    child: Container(
                  child: Text(
                    'Afro-beat',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                )),
                Tab(
                    child: Container(
                  child: Text(
                    'Hip-Hop',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                )),
                Tab(
                    child: Container(
                  child: Text(
                    'Soul Music',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                )),
                Tab(
                    child: Container(
                  child: Text(
                    'Band Music',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                )),
                Tab(
                    child: Container(
                  child: Text(
                    'Country Music',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Afrobeat(0xffff5722),
              HipHop(0xff3f51b5),
              SoulMusic(0xffe91e63),
            ],
          )),
    );
  }
}
