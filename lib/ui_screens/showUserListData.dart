import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_enable/ui_screens/functionalityWillPop.dart';
import 'package:provider_enable/ui_screens/screenPage.dart';
import 'package:provider_enable/ui_screens/userDataModalPage.dart';
import 'package:provider_enable/view_model/userModel.dart';

class ShowUserData extends StatefulWidget {
  @override
  _ShowUserDataState createState() => _ShowUserDataState();
}

class _ShowUserDataState extends State<ShowUserData> {

  Future<Null> _refreshLocalGallery() async{
    print('refreshing stocks...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text("User Data "),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("press1");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDataView()));
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
          ),

          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                },
                child: Icon(
                    Icons.more_vert
                ),
              )
          ),
        ],
      ),
      body:RefreshIndicator(
        onRefresh:_refreshLocalGallery,
        child: ChangeNotifierProvider(
           create: (context)=>UserModel(),

           child:Builder(builder: (context) {

            final model = Provider.of<UserModel>(context);

            if (model.homeState == CheckUserState.Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (model.homeState == CheckUserState.Error) {
              return Center(child: Text('An Error Occurred ${model.message}'));
            }
            final users = model.users;
            return (users.length==null && users.length == 0)?
               Center(child: Container(child: Text("Data Not Found"),))
                :ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                 final user = users[index];
                 return ListTile(
                  title: Text((user.firstName != null && user.firstName.length>0)?user.firstName:"",style: TextStyle(
                    fontSize: 13.0,fontWeight:FontWeight.w700,fontFamily: 'OpenSans',
                  ),),
                  subtitle: Text((user.email != null && user.email.length>0)?user.email:"",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w400),),
                );
              },
            );
          }
          ),
        ),
      ),
    );
  }
}
