import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_enable/view_model/userModel.dart';
class UserDataView extends StatefulWidget {
  @override
  _UserDataViewState createState() => _UserDataViewState();
}

class _UserDataViewState extends State<UserDataView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text("Total Api Data ",),
      ),
      body:ChangeNotifierProvider(
        create:(context)=>UserModel(),
        child: Builder(builder: (context){
        final model=Provider.of<UserModel>(context);
        if(model.homeState==CheckUserState.Loading){
          return Center(child: CircularProgressIndicator());
        }
        if (model.homeState == CheckUserState.Error) {
          return Center(child: Text('An Error Occurred ${model.message}'));
        }if(model.homeState == CheckUserState.Loaded){
         // return Navigator.push(context,MaterialPageRoute(builder: ShowUserData));
        }
        //final user=model.userDataModel;
        final userList=model.userDataModel.data;

        return ListView.builder(
            itemCount:userList.length,
            itemBuilder:(context,int i){
              final userDetail=userList[i];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100.0,
            //child: Text(userList[i].email),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      title: Text(
                        userDetail.email,
                        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w400,fontFamily:"OpenSans"),
                      ),
                      subtitle:Text(userList[i].firstName,
                      style:GoogleFonts.lato(textStyle:TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500)),),
                  ),
                  Text(userDetail.email,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w400),
                  )

                ],
              ),
            ),
          );
        });
        }),
      ),

    );
  }
}
