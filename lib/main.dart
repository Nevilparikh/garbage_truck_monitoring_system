import 'package:flutter/material.dart';

import 'package:flutter_app2/register_user.dart';
import 'package:flutter_app2/user_list.dart';
import 'home_page_admin.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() =>runApp(new MyApp());

String username='';
String level='';
var mobile="";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project',
      debugShowCheckedModeBanner: false,
      home: UserLogin(),
      routes: <String, WidgetBuilder>{
        '/new': (BuildContext context) => RegisterUser(),
        '/login': (BuildContext context) =>  UserLogin(),
        '/home': (BuildContext context) =>  HomePage(username: username,),
        //'/admin': (BuildContext context) => AdminUser(username: username,mobile: mobile,level:level),
        '/admin': (BuildContext context) => AdminUser(),
        '/list': (BuildContext context) => UserList()
      },
    );
  }
}
/*class User1{
  final String username;
  User1(this.username);
}*/
