/*import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Album {
  int id;
  final String name;

  Album({this.id, this.name});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
    );
  }
}

class UserList extends StatefulWidget{
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList>{

  final String uri = 'https://truckmonitoring.000webhostapp.com/';

  Future<List<Album>> fetchAlbum() async {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Album> listOfUsers = items.map<Album>((json) {
        return Album.fromJson(json);
      }).toList();
      // If the server did return a 200 OK response, then parse the JSON.
      return listOfUsers;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  /*final String url='https://truckmonitoring.000webhostapp.com/index.php';
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String>getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );
    print(response.body);
    setState(() {
      var udata = json.decode(response.body);
      data = udata['id'];
    });
    return 'Success';
  }*/
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
      future: fetchAlbum(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) return Center(
            child: CircularProgressIndicator()
        );

        return ListView(
          children: snapshot.data
              .map((data) => ListTile(
            title: Text(data.name),
            //onTap: (){print(data.fName);},
          ))
              .toList(),
        );
      },
    );


      /*body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index){
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    child: Container(
                      child: Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ),
                ],
              ),
              ),
            );
          },
      ),*/
  }

}*/
/*import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {

  final int id;
  final String name;
  final String mobile_no;
  final String password;
  final String level;

  User(
      this.id,
      this.name,
      this.mobile_no,
      this.password,
      this.level,
      );

/*factory Userdata.fromJson(Map<String, dynamic> json) {
    return Userdata(
      id: json['id'],
      fName: json['name'],
    );
  }*/
}

class UserList extends StatefulWidget {
  _UserListWidget createState() => _UserListWidget();
}

class _UserListWidget extends State<UserList> {

  Future<List<User>> fetchUsers() async {
    var data =
        await http.get("https://truckmonitoring.000webhostapp.com/list.php");
    var item = json.decode(data.body);
    print(item[0]);
    //print(item.length);

    /*List<Userdata> listOfUsers = items.map<Userdata>((json) {
        return Userdata.fromJson(json);
      }).toList();
      //print(items);
      return listOfUsers;*/
    List<User> users1 = [];
    print(users1);
    for(var i in item){
      print(i);
      //User user1 = User(i["id"], i["name"], i["mobile_no"], i["password"], i['level']);
      //print("Hi");
      users1.add(User(i['id'], i['name'], i['mobile_no'], i['password'], i['level']));
    }
    /*for (var i in item) {
      print(i);
      User user1 = User(i["id"], i["name"], i["mobile_no"], i["password"], i["level"]);

      users1.add(item);
    }*/
    //users1.add(item);
    print(users1.length);
    return users1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  child: Center(
                child: Text('No data'),
              ));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data[index].name),
                    );
                  });
            }
          },
        ),
      ),
    );
    /*return FutureBuilder<List<Userdata>>(
      future: fetchUsers(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Text('NoData'),
          );

        return ListView(
          children: snapshot.data
              .map((data) => ListTile(
                    title: Text(data.fName),
                    onTap: () {
                      print(data.fName);
                    },
                  ))
              .toList(),
        );
      },
    );*/
  }
}*/
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final String uri = 'https://truckmonitoring.000webhostapp.com/list.php';

  Future<List<dynamic>> _fetchStrings() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<dynamic> listOfString = items.map((json) {
        var name=json['name'];
        var autho=json['level'];
        return (name+ (autho));
      }).toList();

      return listOfString;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("User List"),
            actions: <Widget>[
            //Padding(
            //padding: EdgeInsets.only(right: 20.0),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacementNamed(context, '/admin');
          },
          child: Icon(
            Icons.arrow_back,
            size:26.0,
          ),
        )
    //),
    ]
        ),
    body: FutureBuilder<List<dynamic>>(
    future: _fetchStrings(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data.map((data) {
            GestureDetector();
            return ListTile(
              title: Text(data.toString().toUpperCase()),
            );
          }).toList(),
        );
      },
    ),
    );
  }
}


