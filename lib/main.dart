import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:git_hub_api_proj/api/service.dart' as api;

import 'api/service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  var searchKeyword;
  var responseData;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search GitHub User'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(controller: myController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter user name',
                    icon: Icon(Icons.search)
                ),),
              Expanded(
                  child: _isLoading
                      ? new CircularProgressIndicator()
                      : new ListView.builder(
                          itemCount:
                              responseData != null ? responseData.length : 0,
                          itemBuilder: (context, i) {
                            print(responseData[i]["login"]);
                            final usr = responseData[i]["login"];
                            return new FlatButton(
                                padding: new EdgeInsets.all(0.0),
                                child: new UserCell(usr),
                                onPressed: () {
                                  print("$i pressed");
//                                  Navigator.push(
//                                      context,
//                                      new MaterialPageRoute(
//                                          builder: (context) =>
//                                              new UserPage(vid["id"])));
                                });
                            return UserCell(usr);
                          })),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          setState(() {
            this.searchKeyword = myController.text;

          });
          getResponse(this.myController.text);
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }

  getResponse(String s) async {
    ApiService apiService = new ApiService();
    final response = await apiService.searchUsers(s);
    setState(() {
      responseData = response;
    });
  }
}

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
        padding: new EdgeInsets.all(16),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Image.network(usr["imageUrl"]),
//            new Container(height: 8),
            new Text(
              usr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            new Divider()
          ],
        ));
  }
}
