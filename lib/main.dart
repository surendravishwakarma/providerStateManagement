import 'package:flutter/material.dart';
import 'package:provider_enable/ui_screens/dataShowUsingSetstateWithDataModelClass.dart';
import 'package:provider_enable/ui_screens/loginScreenPage.dart';

import 'ui_screens/showUserListData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //fontFamily: "OpenSans"
      ),
      home: LoginPage(),//LoginPage
    );
  }
}

//ShowUserData