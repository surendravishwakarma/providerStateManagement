import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_enable/models/userDataModel.dart';
import 'dart:convert';

import 'package:provider_enable/services/baseUrl.dart';

class UserSetStateUsingModel extends StatefulWidget {
  @override
  _UserSetStateUsingModelState createState() => _UserSetStateUsingModelState();
}

class _UserSetStateUsingModelState extends State<UserSetStateUsingModel> {
List<Data> userDataList=[];
bool isLoading;
  @override
  void initState() {
    super.initState();
     isLoading=true;
    getUserDataFromApi();
  }

  void getUserDataFromApi()async{
      http.Response response=await http.get(checkUserApi);
      print(response.body);
      print(response.statusCode);
      if(response != null && response.statusCode==200){
        Map<String,dynamic> responseData=json.decode(response.body);
        UserDataModel dataMap=UserDataModel.fromJson(responseData);
        if(dataMap.data.length>0){
          userDataList=List.from(dataMap.data);
        }
      }
      setState(() {
        isLoading=false;
      });
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title:Text("User Data Model"),
       ),
      body:Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: (userDataList != null && userDataList.length>0)?ListView.builder(
              itemCount: userDataList.length,
                itemBuilder:(context,index){
              return Container(
                height: 150.0,
                child: Card(
                  elevation: 3.0,
                  child: Text(userDataList[index].email),
                ),
              );
            }):Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: 40.0,),
                Text("Please wait...")
              ],
            )),
          ),
        ],
      ),
    );
  }
}
