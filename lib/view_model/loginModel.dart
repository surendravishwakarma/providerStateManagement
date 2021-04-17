
import 'package:flutter/widgets.dart';
import 'package:provider_enable/models/loginAuth.dart';
import 'package:provider_enable/models/typiCodeUser.dart';
import 'package:provider_enable/services/userApiResponse.dart';

enum LoginState{
  Initial,
  Loading,
  Loaded,
  Error,
}

class LoginModel extends ChangeNotifier{
  String userN;
  String passN;
  String token;
  LoginState _homeState = LoginState.Initial;
  String message = '';
  LoginModel({this.userN,this.passN});

  // LoginModel(){
  //
  //  // loginUser(String us,String pass);
  // }

  LoginState get homeState => _homeState;

  Future<Map> loginUser(us,pass) async{
    var apiUsers;
    _homeState = LoginState.Loading;
    try {
       apiUsers = await UserApiCall.login(us,pass);
       token=apiUsers.map<LoginModelToken>((json) => LoginModelToken.fromJson(json)).toList();
      _homeState = LoginState.Loaded;
      return apiUsers;
    } catch (e) {
      print(e);
      message = '$e';
      _homeState = LoginState.Error;
    }
    notifyListeners();
    return apiUsers;
  }

}