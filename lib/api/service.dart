import 'dart:convert';
import 'package:http/http.dart' as http;

import 'ApiUrl.dart';
class ApiService {

  Future<List> searchUsers(String user) async {
    final response = await http.get(ApiUrl.SEARCH_USER_URL + user);

    if (response.statusCode == 200) {
      print("response code 200");
      var res = json.decode(response.body);
      List list = res["items"];
      return list;
    } else
      print(response.statusCode);
  }

  Future getUserPage(String name) async{
    final response = await http.get(name);

    if(response.statusCode ==200){
      var res = json.decode(response.body);
      return res;
    }else
      print(response.statusCode);
  }
}
