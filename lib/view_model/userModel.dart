
import 'package:flutter/cupertino.dart';
import 'package:provider_enable/models/userDataModel.dart';
import 'package:provider_enable/services/userApiResponse.dart';
enum CheckUserState{
  Initial,
  Loading,
  Loaded,
  Error,
}

class UserModel extends ChangeNotifier {
  UserDataModel userDataModel=UserDataModel();
  List<Data> users= new List();
  int pageValue;
  CheckUserState _homeState = CheckUserState.Initial;
  String message = '';

  UserModel() {
    _fetchUsers();
  }
  CheckUserState get homeState => _homeState;

  Future<void> _fetchUsers() async {
    _homeState = CheckUserState.Loading;
    try {
      Map userDataMap = await UserApiCall.getAllUser();
      List userList=userDataMap["data"];
      users=userList.map<Data>((json) => Data.fromJson(json)).toList();
      userDataModel= UserDataModel.fromJson(userDataMap);
      _homeState = CheckUserState.Loaded;
    } catch (e) {
      message = '$e';
      _homeState = CheckUserState.Error;
    }
    notifyListeners();
  }

}