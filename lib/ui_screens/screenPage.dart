
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_enable/view_model/typiCodeModel.dart';
import 'package:provider_enable/view_model/userModel.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: ChangeNotifierProvider(

        create: (context)=>TypiCodeModel(),

        child: Builder(builder:(context){
          final model = Provider.of<TypiCodeModel>(context);
          if (model.homeState == TypiCodeState.Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (model.homeState == TypiCodeState.Error) {
            return Center(child: Text('An Error Occurred ${model.message}'));
          }
          final users = model.typiList;

          return Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder:(BuildContext context,int i){
                      final user = users[i];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.address.geo.lat),//address.geo.lat
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
        ),
      ),

    );
  }
}
// body:ChangeNotifierProvider(
//   create: (context)=>UserModel(),
//   child: Builder(builder: (context){
//     final model=Provider.of<UserModel>(context);
//     if (model.homeState == CheckUserState.Loading) {
//       return Center(child: CircularProgressIndicator());
//     }
//     if (model.homeState == CheckUserState.Error) {
//       return Center(child: Text('An Error Occurred ${model.message}'));
//     }
//     final users = model.userDataModel;
//     final userList=users.data;
//     return Flex(
//       direction: Axis.vertical,
//      children: [
//        Container(
//          child: Center(
//            child:Text(users.total.toString()),
//          ),
//        ),
//        Expanded(child: Container(
//          child: ListView.builder(
//            itemCount: userList.length,
//            itemBuilder: (context, index) {
//              final user = userList[index];
//              return Container(
//                height: 100.0,
//                child: ListTile(
//                  title: Text(user.firstName),
//                  subtitle: Text(user.email),
//                ),
//              );
//            },
//          ),
//        ))
//      ],
//     );
//   },),
// )