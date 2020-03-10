import 'package:flutter/material.dart';


class UserCell extends StatefulWidget {
  final usr;
  UserCell(this.usr);

  @override
  State<StatefulWidget> createState() {
    return new UserCellState(usr);
  }
}

class UserCellState extends State<UserCell> {
  final usr;
  UserCellState(this.usr);

  // TODO: impelement user info
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.all(6),
        child: new Card(
          child: ListTile(
            leading: Image.network(usr["avatar_url"]),
            title: Text(usr["login"]),
            subtitle: Text(
                'A sufficiently long subtitle warrants three lines.'
            ),
            trailing: Text("num of repos"),

            isThreeLine: true,
          ),
        )
    );
  }
}