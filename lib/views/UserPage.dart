import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  var responseData;

  UserPage(this.responseData);

  @override
  State<StatefulWidget> createState() {
    return new UserPageState(responseData);
  }
}

class UserPageState extends State<UserPage> {
  final responseData;
  UserPageState(this.responseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new  CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(responseData["login"]),
              backgroundColor: Colors.white70,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background:
                Image.network(responseData["avatar_url"], fit: BoxFit.cover),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 150.0,
              delegate: SliverChildListDelegate(
                [
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[new Text("type: " + responseData["type"], style:
                        TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black
                        ),)],
                      )),

                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[new Text("link: " + responseData["url"])],
                      )),

                  Container(color: Colors.green),
                  Container(color: Colors.orange),
                  Container(color: Colors.yellow),
                  Container(color: Colors.pink),
                ],
              ),
            ),
          ],
        ));



  }
}