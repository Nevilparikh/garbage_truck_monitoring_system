import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController user = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController pass = TextEditingController();
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
                    child: Text("LOGIN"),
                    onPressed: (){
                      // _onLoading();
                    },
                    //onPressed: (() =>

                    //Navigator.of(context).pushNamed('/home')),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
