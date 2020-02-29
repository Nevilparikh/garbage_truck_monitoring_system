import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//import 'package:zoomable_image/zoomable_image.dart';
import 'main.dart';

class AdminUser extends StatefulWidget {

  //final String n;
  //HomePage(this.n);
  AdminUser({this.username,this.mobile,this.level});

  final String username;
  final String level;
  final mobile;

  //final User1 use1;
  //AdminUser({Key key, this.use1}) : super(key: key);
  @override
  _AdminUserState createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  //User1 use1;
  //_AdminUserState(this.use1);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Icon(
                  Icons.lock_outline,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
        child: Container(
    child: Center(
    child: Column(
    children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(
            height: 200.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/charusat.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
          Padding(
          padding: EdgeInsets.only(
            top: 130.0,
            left: 180.0,
          ),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) =>
                      AlertDialog(
                        title: Text("No.1"),
                        content: Text("Filled Up: 70%"),
                      ));
            },
            child: Icon(Icons.delete, color: Colors.blue, size: 10.0),
            /*child: Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Icon(Icons.delete,color: Colors.blue,size: 10.0),
                      ),*/
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 170.0,
            left: 145.0,
          ),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) =>
                      AlertDialog(
                        title: Text("No.2"),
                        content: Text("Filled Up: 70%"),
                      ));
            },
            child: Icon(Icons.delete, color: Colors.blue, size: 10.0),
            /*child: Positioned(
                        right: 145.0,
                        bottom: 20.0,
                        child: Icon(Icons.delete,color: Colors.blue,size: 10.0),
                      ),*/
          ),
        ),
              Padding(
                padding: EdgeInsets.only(
                  top: 90.0,
                  left: 340.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) =>
                            AlertDialog(
                              title: Text("No.3"),
                              content: Text("Filled Up: 70%"),
                            ));
                  },
                  child: Icon(Icons.delete, color: Colors.blue, size: 10.0),
                  /*child: Positioned(
                        right: 145.0,
                        bottom: 20.0,
                        child: Icon(Icons.delete,color: Colors.blue,size: 10.0),
                      ),*/
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 150.0,
                  left: 370.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) =>
                            AlertDialog(
                              title: Text("No.4"),
                              content: Text("Filled Up: 70%"),
                            ));
                  },
                  child: Icon(Icons.delete, color: Colors.blue, size: 10.0),
                  /*child: Positioned(
                        right: 145.0,
                        bottom: 20.0,
                        child: Icon(Icons.delete,color: Colors.blue,size: 10.0),
                      ),*/
                ),
              ),


        /*Positioned(
                    right: 145.0,
                    bottom: 20.0,
                    child: Icon(Icons.delete,color: Colors.blue,size: 10.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("No.2"),
                            content: Text("This is my content"),
                          )
                      );
                    },
                  ),
                  Positioned(
                    right: 170.0,
                    top: 150.0,
                    bottom: 140,
                    child: Icon(Icons.delete,color: Colors.blue,size: 10.0),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Icon(Icons.delete,color: Colors.blue,size: 10.0),
                  ),*/

      ],
    )),
       SizedBox(
         height: 30.0,
       ),
      Container(
        child: RaisedButton(
          child: Text("Route"),
          onPressed: (){
            showDialog(
                context: context,
                builder: (_) =>
                    AlertDialog(
                      //title: Text("Route"),
                      content: Text("This is my content"),
                    ));
          },
        ),
      ),
            ]
    ),
    ),
        ),
        ),
      ),

    /*body: PhotoView(
        //fit: BoxFit.cover,
        backgroundDecoration: BoxDecoration(color: Colors.white),
        imageProvider: AssetImage('assets/images/charusat.jpg',
          //withZoom: true,
          //height: double.infinity,
          /*width: size.width,
          fit: BoxFit.cover,
          alignment: Alignment.center,*/
          ),
      ),*/
    drawer: Drawer(
    child: ListView(
    children: <Widget>[
    ListTile(
    title: Text("Admin"),
    trailing: Icon(Icons.arrow_back),
    onTap: () {
    Navigator.pop(context);
    },
    ),
    UserAccountsDrawerHeader(
    accountName: Text('$username'),
    accountEmail: null,
    currentAccountPicture: CircleAvatar(
      child: GestureDetector(
        child: Text(
          '${username[0]}',
          style: TextStyle(fontSize: 40),
        ),
        onTap: (){
          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text('$level'),
                    //trailing: Icon(Icons.cancel),
                    content: Text('username: $username''                           ''mobile: $mobile'),
                  ));
          /*Alert(
              context: context,
              title: "Info",
              desc: '$username')
              .show();*/
        },
      ),
    backgroundColor: Theme.of(context).primaryColorDark,
    foregroundColor: Theme.of(context).canvasColor,
    ),
    ),
    ListTile(
    title: Text("notifications"),
    trailing: Icon(Icons.mail),
    onTap: () {
    Navigator.pushReplacementNamed(context, '/admin');
    },
    ),
    /*ListTile(
    title: Text("New User"),
    trailing: Icon(Icons.person),
    onTap: () {
    Navigator.pushReplacementNamed(context, '/new');
    },
    ),*/
      ListTile(
        title: Text("Users"),
        trailing: Icon(Icons.list),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/list');
        },
      ),
    ],
    ),
    ), // new
    );
  }
}
