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


