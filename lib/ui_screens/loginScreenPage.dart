import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_enable/ui_screens/showUserListData.dart';
import 'package:provider_enable/view_model/loginModel.dart';
import 'package:provider_enable/view_model/typiCodeModel.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName=new TextEditingController();
  TextEditingController password=new TextEditingController();

  LoginModel lmObj=new LoginModel();

  void callLoginApi(String userName,String password)async{
      Map response= await lmObj.loginUser(userName,password);
      if(response != null && response.length >0){
        print(">>>>>>>>>>>>>>>>>>>>$response");
        Navigator.push(context, MaterialPageRoute(builder: (_)=>ShowUserData()));
      }
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context)=>LoginModel(),
      child:Builder(builder: (context){
          final model=Provider.of<LoginModel>(context);
          if(model.homeState==LoginState.Loading){
            return Center(child: CircularProgressIndicator());
          }
          if(model.homeState==LoginState.Error){
            return Center(child: Text('An Error Occurred ${model.message}'));
          }
          final users = model.token;
          print(">>>>>>>>>>>token value>>>>>>$users");
         return Scaffold(
            appBar: AppBar(
              title: Text("Login Page"),
              centerTitle: true,
            ),
            body:Container(
              child: Form(
                child:Column(
                  children: [
                    Container(
                      child: Text(users != null && users.length>0?users:""),
                    ),
                    Container(
                      child: Text("User Email"),
                    ),
                    Container(
                      child:TextFormField(
                        style: TextStyle(fontWeight:FontWeight.w500,fontSize: 20.0),
                        controller: userName,
                        decoration: InputDecoration(
                          hintText: "Enter user email",
                          hintStyle: TextStyle(
                            fontSize: 20.0,fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      child: Text("User Password"),
                    ),

                    Container(
                      child:TextFormField(
                        controller: password,
                        style: TextStyle(fontWeight:FontWeight.w500,fontSize: 20.0),
                        decoration: InputDecoration(
                          hintText: "Enter Your password",
                          hintStyle: TextStyle(
                              fontSize: 20.0
                          ),
                        ),
                      ),
                    ),

                    RaisedButton(
                        child: Text("Login"),
                        onPressed:(){
                          callLoginApi(userName.text,password.text);
                        }
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}


