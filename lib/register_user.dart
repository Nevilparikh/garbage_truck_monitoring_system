import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController user = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController pass = TextEditingController();
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
      userRegistration();
      //Navigator.pop(context); //pop dialog
    });
  }
  Future userRegistration() async{

    // Showing CircularProgressIndicator.
    print("Hi");
    // SERVER API URL
    var url = 'https://truckmonitoring.000webhostapp.com/adduser.php';

    // Store all data with Param Name.
    //var data = {'user': user.text, 'address':address.text,'mob': mob.text, 'pass' : pass.text};
    //print(data);

    // Starting Web API Call.
    final response = await http.post(url, body: {'user': user.text, 'address':address.text,'mob': mob.text, 'pass' : pass.text});
    print(response.body);

    // Getting Server response into variable.
    //var message = json.decode(response.body);
    //print(message);

    // ignore: unrelated_type_equality_checks
    if(response.body == 'Email Already Exist'){
      print("hell");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("User already exist"),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/new');
                },
              ),
            ],
          );
        },
      );
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("user added successfully..."),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/new');
                },
              ),
            ],
          );
        },
      );
    }
    // If Web call Success than Hide the CircularProgressIndicator.
    /*showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );*/

  }
  /*TextEditingController user = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pass = TextEditingController();*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rester User'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Icon(
                  Icons.arrow_back,
                  size:26.0,
                ),
              )
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.width/10),
            //color: Colors.white,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    //autofocus: false,
                    //obscureText: false,
                    controller: user,
                    decoration: InputDecoration(
                        labelText: "User Name",
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
                    height: 50,
                  ),
                  TextField(
                    //autofocus: false,
                    //obscureText: false,
                    controller: address,
                    decoration: InputDecoration(
                        labelText: "Address",
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
                    height: 50,
                  ),
                  TextField(
                    //autofocus: false,
                    //obscureText: false,
                    keyboardType: TextInputType.number,
                    controller: mob,
                    decoration: InputDecoration(
                        labelText: "Mobile Number",
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
                    height: 50,
                  ),
                  TextField(
                    //autofocus: false,
                    //obscureText: false,
                    keyboardType: TextInputType.visiblePassword,
                    controller: pass,
                    decoration: InputDecoration(
                        labelText: "Password",
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
                    height: 50,
                  ),
                  RaisedButton(
                    child: Text("Register"),
                    onPressed: (){
                      _onLoading();
                    },
                    //onPressed: (() =>

                    //Navigator.of(context).pushNamed('/home')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
