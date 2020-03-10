import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_hub_api_proj/views/UserCell.dart';
import 'package:git_hub_api_proj/views/UserPage.dart';

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
              TextField(
                controller: myController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter user name',
                    icon: Icon(Icons.search)),
              ),
              Expanded(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : new ListView.builder(
                          itemCount:
                              responseData != null ? responseData.length : 0,
                          itemBuilder: (context, i) {
                            final usr = responseData[i];
                            return new FlatButton(
                                padding: new EdgeInsets.all(0.0),
                                child: new UserCell(usr),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new UserPage(responseData[i])));
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
            _isLoading = true;
          });
          getResponse(this.myController.text);
        },
        tooltip: 'Send',
        child: Icon(Icons.send),
      ),
    );
  }

  getResponse(String user) async {
    ApiService apiService = new ApiService();
    final response = await apiService.searchUsers(user);
    setState(() {
      responseData = response;
      responseData != null ? _isLoading = false : _isLoading = true;
    });
  }
}

