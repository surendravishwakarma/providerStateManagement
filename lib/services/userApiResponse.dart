import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider_enable/services/baseUrl.dart';

class UserApiCall {
  // static UserApiCall _instance;
  // UserApiCall._();
  // static UserApiCall get instance {
  //   if (_instance == null) {
  //     _instance = UserApiCall._();
  //   }
  //   return _instance;
  // }

 static Future<Map> getAllUser() async {
    final response = await http.get(checkUserApi, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    print(response.statusCode);
    print(response.body);
      final responseBody=json.decode(response.body);
      return responseBody;
  }

 static Future<List> fetchApiData() async {
   final getUser =
   await http.get(typiCode,
       headers: {'Content-type': 'application/json',
          'Accept': 'application/json',
         });
   print(getUser.statusCode);
   print(getUser.body);
   final responseBody = jsonDecode(getUser.body);
   return responseBody;
 }

 static Future<Map> login(String userMail,String password) async {
   final getUser =
   await http.post("https://reqres.in/api/login",
       headers: {
     // 'Content-type': 'application/json',
         'Accept': 'application/json',
       },
    body: {
     "email":userMail,
     "password": password
    }
     );
   print(getUser.statusCode);
   print(getUser.body);
   final responseBody = jsonDecode(getUser.body);
   return responseBody;
 }

}

