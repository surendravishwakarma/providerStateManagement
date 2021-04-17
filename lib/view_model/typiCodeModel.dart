
import 'package:flutter/widgets.dart';
import 'package:provider_enable/models/typiCodeUser.dart';
import 'package:provider_enable/services/userApiResponse.dart';

enum TypiCodeState{
  Initial,
  Loading,
  Loaded,
  Error,
}

class TypiCodeModel extends ChangeNotifier{
List<TypiCode> typiList=new List();
TypiCodeState _homeState = TypiCodeState.Initial;
String message = '';

TypiCodeModel(){
  _fetchTypeUsers();
}

TypiCodeState get homeState => _homeState;

Future<void> _fetchTypeUsers() async {
  _homeState = TypiCodeState.Loading;
  try {
    List apiUsers = await UserApiCall.fetchApiData();
    typiList=apiUsers.map<TypiCode>((json) => TypiCode.fromJson(json)).toList();
    _homeState = TypiCodeState.Loaded;
  } catch (e) {
    print(e);
    message = '$e';
    _homeState = TypiCodeState.Error;
  }
  notifyListeners();
}

}