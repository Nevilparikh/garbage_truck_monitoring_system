import 'package:flutter/material.dart';
import 'main.dart';

class HomePage extends StatefulWidget{
  //final String n;
  //HomePage(this.n);
  //final User1 user;
  //HomePage({Key key, this.user}) : super(key: key);
  HomePage({this.username, mobile});
  final String username;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  //String n;
  //User1 user;
  //_HomePageState(this.user);
  //void initState(){
  //  super.initState();
  //}
  //String get value => this.value;
  //int _currentIndex = 0;
  //final List<Widget> _children = [
  //Navigator.pushReplacementNamed(context, '/home'),
  //Navigator.pushReplacementNamed(context, '/login'),
  //Navigator.pushReplacementNamed(context, '/admin')
  //];
  @override
  Widget build(BuildContext context) {
    //var user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Icon(
                  Icons.lock_outline,
                  size:26.0,
                ),
              )
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("User"),
              trailing: Icon(Icons.arrow_back),
              onTap:(){
                Navigator.pop(context);
              },
            ),
            UserAccountsDrawerHeader(
              accountName: Text('$username'), accountEmail: null,
              currentAccountPicture: CircleAvatar(
                child: Text('${username[0]}', style: TextStyle(fontSize: 40),),
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Theme.of(context).canvasColor,),
            ),
            ListTile(
              title: Text("Profile"),
              trailing: Icon(Icons.home),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text("mail"),
              trailing: Icon(Icons.mail),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text("Profile"),
              trailing: Icon(Icons.person),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
      ), // new
      /*bottomNavigationBar: BottomNavigationBar(// new// new
        currentIndex: 0,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),*/
    );
  }
}