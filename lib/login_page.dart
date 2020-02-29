import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:http/http.dart' as http;


class UserLogin extends StatefulWidget {
  //final String title;
  //UserLogin({Key key, this.title}) : super(key: key);
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> with SingleTickerProviderStateMixin{

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  String msg='';

  //AnimationController controller;
  //Animation<double> animation_rotation;

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          height: 40,
          width: 50,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: 3), () {
      _login();
      //Navigator.pop(context); //pop dialog
    });
  }

  // ignore: missing_return
  Future<List> _login() async{
    print("HII i am going in");
    final response = await http.post("https://truckmonitoring.000webhostapp.com/", body:{
    //final response = await http.post('http://10.0.2.2/login.php', body:{
      "username": user.text,
      "password": pass.text,
    },
    );
    print(response.body);
    //String n = user.text;
    var datauser = json.decode(response.body);
    print(datauser);
    if(datauser.length==0){
      print("Hi");
      setState(() {
        msg="Login Failed";
        Future.delayed(Duration(seconds: 3), () {
          return Navigator.pushReplacementNamed(context, '/login');
        });
      });
    }else {
      if(datauser[0]['level']=='admin'){
        /*User1 use = User1(user.text);
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AdminUser(
                      use1: use,
                    )));*/
        Navigator.pushReplacementNamed(context, '/admin');
      }
      else if(datauser[0]['level']=='user') {
        /*User1 user2 = User1(user.text);
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage(
                      user: user2,
                    )));*/
        Navigator.pushReplacementNamed(context, '/home');
      }
      setState(() {
          username= datauser[0]['name'];
          mobile= datauser[0]['mobile_no'];
          level= datauser[0]['level'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
            ),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.width/10),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image(
                      image: AssetImage("assets/gif/dust1.gif"),
                    ),
                    //child: Text('Login',style: TextStyle(fontSize: 50.0,color: Colors.white),),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    child: TextField(
                      style: TextStyle(color: Colors.white,),
                      autofocus: false,
                      obscureText: false,
                      cursorColor: Colors.white,
                      //keyboardType: TextInputType.emailAddress,
                      controller: user,
                      decoration: InputDecoration(
                          labelText: "Name",
                          //hintText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1,
                                  //color: Colors.green,
                                  style: BorderStyle.solid))),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: TextField(
                      style: TextStyle(color: Colors.white,),
                      autofocus: false,
                      obscureText: true,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: pass,
                      decoration: InputDecoration(
                          labelText: "Password",
                          //hintText: "Password",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                  style: BorderStyle.solid))),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    child: RaisedButton(
                        child: Text("LOGIN"),
                        onPressed: (){
                          _onLoading();
                        },
                  ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      child: Row(
                        children: <Widget>[
                          Text('Does not have account?'),
                          FlatButton(
                            textColor: Colors.white,
                            child: Text(
                              'Sign up',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/new');
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                  /*SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/images/xyz1.png'),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  //Text("Email",style: TextStyle(fontSize: 16),),
                  TextField(
                    autofocus: false,
                    obscureText: false,
                    //keyboardType: TextInputType.emailAddress,
                    controller: user,
                    decoration: InputDecoration(
                        labelText: "Name",
                        //hintText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  //Text("Password",style: TextStyle(fontSize: 16),),
                  TextField(
                    autofocus: false,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: pass,
                    decoration: InputDecoration(
                        labelText: "Password",
                        //hintText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    child: Text("LOGIN"),
                    onPressed: (){
                      _onLoading();
                    },
                    //onPressed: (() =>

                    //Navigator.of(context).pushNamed('/home')),
                  ),
                  Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}