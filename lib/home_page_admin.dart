import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;

//import 'package:latlong/latlong.dart';
//import 'package:map_view/map_view.dart';
//import 'package:photo_view/photo_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

//import 'package:zoomable_image/zoomable_image.dart';
import 'main.dart';

/*void main(){
  MapView.setApiKey("AIzaSyBBojDiyFeO2Sl-sCgC6X5Vcu5P7e8pkns");
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AdminUser(),
  ));
}*/
/*class Album {

  //final String title;

  Album({this.id1, this.id2});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id1: json['userId'],
      id2: json['id'],
    );
  }
}*/
class AdminUser extends StatefulWidget {
  //final String n;
  //HomePage(this.n);
  AdminUser({this.username, this.mobile, this.level});

  final String username;
  final String level;
  final mobile;

  //final User1 use1;
  //AdminUser({Key key, this.use1}) : super(key: key);
  @override
  _AdminUserState createState() => _AdminUserState();
}
/*void _showDialog() {
  // flutter defined function
  showDialog(
    con text: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Alert Dialog title"),
        content: new Text("Alert Dialog body"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}*/

class _AdminUserState extends State<AdminUser> {
  final Set<Polyline> _polyline = {};
  Completer<GoogleMapController> myController = Completer();
  BitmapDescriptor myIcon;
  var value;

  //TextEditingController id1 = TextEditingController();
  //TextEditingController id2 = TextEditingController();
  //TextEditingController id3 = TextEditingController();
  //TextEditingController id4 = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController markername = TextEditingController();
  var idd1;
  var idd2;
  var idd3;
  var idd4;

  final String uri = 'https://truckmonitoring.000webhostapp.com/dustbinout.php';

  onClear() {
    setState(() {
      //id1.text = "";
      //id2.text = "";
      //id3.text = "";
      //id4.text = "";
      id.text = "";
      markername.text = "";
    });
  }

  var leng;
  var arr = [];
  var r;
  var arr3 = [];

  //var k = [];

  /*Future<List> _fetchString() async {
    var response = await http.get(uri);
    var value1 = json.decode(response.body);
    value = value1;
    print(value);
    //myList.asMap().entries.map((entry){

    //})
    r = value[0].keys.toList();
    print(r);

    var k = value[0].values.toList();
    print(k.length - 1);

    /*for(int i=0;i<(r.length-1);i++){

      //arr3.add("$r[i]":"$k[i]");
    }*/
    /*for(int i=0;i<(k.length-1);i++){
      if(r[i].value>=75){

      }
    }*/
    //leng = k.length;
    //var keys = Object.keys(value);
    //print(value[0].values);
    idd1 = value[0]['id_1'];
    idd2 = value[0]['id_2'];
    idd3 = value[0]['id_3'];
    idd4 = value[0]['id_4'];
    var arr1 = [];
    var ar = [];
    //print(arr1[0]);
    print(k[1]); //=value[0];
    for (int i = 0; i < (k.length - 1); i++) {
      //print(arr1[0]);
      print(k[i + 1]);
      arr1.add(k[i + 1]);
      ar.add(r[i + 1]);
    }
    print(arr1);
    print(ar);
    //var arr1 = [idd1, idd2, idd3, idd4];
    //print(arr1);
    //print(arr1[0]);
    arr3 = ar;
    arr = arr1;
    //print(arr[0]);
  }*/

  //= value[0]['id_1'];
  var marksid;

  Future addValue() async {
    print(id.text);
    var url = 'https://truckmonitoring.000webhostapp.com/dustbinin.php';
    print(marksid);
    final response1 = await http.post(url, body: {
      'markid': marksid,
      'id': id.text,
      //'id2': id2.text,
      //'id3': id3.text,
      //'id4': id4.text
    });
    print(response1.body);
    _onLoading();
    //_fetchMarker();
    onClear();
    /*print('hi');
    print(idd1);
    //print(id1.text);
    if (id1.text == '') {
      id1.text = idd1;
    }
    if (id2.text == '') {
      id2.text = idd2;
    }
    if (id3.text == '') {
      id3.text = idd3;
    }
    if (id4.text == '') {
      id4.text = idd4;
    }
    var url = 'https://truckmonitoring.000webhostapp.com/dustbinin.php';
    final response1 = await http.post(url, body: {
      'id1': id1.text,
      'id2': id2.text,
      'id3': id3.text,
      'id4': id4.text
    });
    print(response1.body);
    print(id1.text);
    print(id2.text);
    print(id3.text);
    print(id4.text);
    Navigator.pop(context);
    //_fetchString();
    onClear();
    /*if(id1==null){
     id1.text= value[0]['id_1'];
    }

    print(id1.text);
    */*/
  }

  var idval = [];
  int lastId;
  int _markerIdCounter = 1;

  Future updateTable() async {
    var url1 = 'https://truckmonitoring.000webhostapp.com/update.php';
    final response = await http.post(url1, body: {
      'id': "id_$_markerIdCounter",
    });
    idval.add("id_$_markerIdCounter");
    print(response.body);
    //c++;
  }

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.599588, 72.820503),
    zoom: 17,
  );
  LatLng _lastMapPosition = LatLng(22.599588, 72.820503);
  Set<Marker> allMarker = {};
  List<Marker> finalMarks = [];
  List<LatLng> latlang = [];

  //List<LatLng> latlngSegment1 = List();
  static const LatLng _mark1 = const LatLng(22.599588, 72.820503);
  static MarkerId markerId1 = MarkerId("1");

  /*static const LatLng _mark1 = const LatLng(22.599588, 72.820503);
  static MarkerId markerId1 = MarkerId("1");
  static const LatLng _mark2 = const LatLng(22.600028, 72.820945);
  static MarkerId markerId2 = MarkerId("2");
  static const LatLng _mark3 = const LatLng(22.600706, 72.820355);
  static MarkerId markerId3 = MarkerId("3");
  static const LatLng _mark4 = const LatLng(22.599365, 72.819376);
  static MarkerId markerId4 = MarkerId("4");
  static const LatLng _mark5 = const LatLng(22.602730, 72.821262);
  static MarkerId markerId5 = MarkerId("5");*/
  var pos1;
  var pos2;
  var c = 1;
  List<LatLng> mark = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;

  /*void _onAddMarker(){
    //print(pos1.toString());
    /*setState(() {
      allMarker.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("id_$c"),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: pos1,
        onTap: (){
          //print(${pos1.coordinates.latitude});
          //valueadd();
          /*for(int i=0;i<mark.length;i++){
            print(pos2);
            if(pos2 == mark[i]){
              print(idval[i]);
              valueadd();
            }
          }*/

         // print(mark.length);
          //print(idval);
          /*for(int i=0;i<mark.length;i++){
            print(mark[i]);
            print(pos2);
            if(pos2 == mark[i]){
              print(idval[i]);
              Alert(
                  context: context,
                  title: "Admin Building",
                  content: Column(
                    children: <Widget>[
                      Container(
                        //child: Text('${value[0]['id_4']}%'),
                      ),
                      /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                      /* TextField(
                    controller: id4,
                    decoration: InputDecoration(
                      labelText: 'Enter value...',
                    ),
                  ),*/
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () {

                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ]).show();
            }
          }*/
        },
        icon: BitmapDescriptor.defaultMarker,

      ));
    });
    print("_onaddmarker");
    mark.add(pos1);
    updateTable();*/
  }*/
  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  var ln = 0;
  var lat;
  var long;
  var markId;

  Future updateMarker() async {
    var url2 = 'https://truckmonitoring.000webhostapp.com/markerin.php';
    print(lat.toString());
    print(long.toString());
    print(markername.text);
    print(_markerIdCounter.toString());
    final response2 = await http.post(url2, body: {
      'markId': markername.text,
      'lat': lat.toString(),
      'long': long.toString(),
      'markid1': _markerIdCounter.toString(),
      //'dbMarker': lat.toString(),
    });
    print("Hilxsl");
    print(response2.body);
    //idval.add("id_$c");
    //print("updatetable");
    ln++;
  }

  Set<Marker> markes = {};
  var markedspots = [];
  var values = [];
  var vals = [];
  int ki;

  /*Future _fetchvalue() async{
    var url4 = 'https://truckmonitoring.000webhostapp.com/dustbinout.php';
    var response4 = await http.post(url4);
    var value1;
    value1 = json.decode(response4.body);
    print(value1);
    var valuesList = [];
    vals.clear();
    for (int i = 0; i < value1.length; i++) {
      valuesList.add(value1[i].values.toList());
      print(valuesList[i][0]);
      vals.add(valuesList[i][1]);
      print(vals[i]);
      ki = i;
      if(vals[ki] == null){
        vals[ki] = '0';
      }
      final Uint8List markerIcon = await getBytesFromCanvas(Size(100, 100));
  }*/
  var vals1 = [];
  List<String> markersnames = [];
  List<String> markersnamesr = [];
  List<String> markersnamesg = [];
  List<String> markersnamesy = [];
  var arr6 = [];
  var markersname;
  var arr9 = [];
  int temps = 0;
  var counts = 0;

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
      _fetchMarker();
      Navigator.pop(context); //pop dialog
    });
  }

  void xyz(){
    if(counts == 1){
      jp = 1;

      Alert(
          context: context,
          title: 'Notification',
          content: Container(
            child: Text('$counts dustbin is filled more than 85%.'),
          )
      ).show();
    }
    if(counts > 1){
      jp =1;
      Alert(
          context: context,
          title: 'Notification',
          content: Container(
            child: Text('$counts dustbins are filled more than 85%.'),
          )
      ).show();
    }
  }
  bool isLoading;
  Future _fetchMarker() async {
    //isLoading = false;
    /*if(isLoading == false){
      Center(
        child: CircularProgressIndicator(),
      );
    }*/
    temps++;
    counts = 0;
    print(temps);
    _polyline.clear();
    red = green = yellow = 0;
    markes.clear();
    vals.clear();
    vals1.clear();
    allMarker.clear();
    arr5.clear();
    arr6.clear();
    arr7.clear();
    arr9.clear();
    markersnames.clear();
    markersnamesg.clear();
    markersnamesr.clear();
    markersnamesy.clear();
    var url3 = 'https://truckmonitoring.000webhostapp.com/markerout.php';
    var response3 = await http.get(url3);
    markedspots = json.decode(response3.body);
    //final Uint8List markerIcon = await getBytesFromAsset('assets/images/Bin.png', 70);
    //final Uint8List markerIcon = await getBytesFromCanvas(Size(100,100), 'assets/images/Bin.png');
    //final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon));
    print(markedspots);
    arr5.add(LatLng(22.597694985693487, 72.82150704413652));
    markersnames.add('START');
    arr6.add(22.597694985693487);
    arr6.add(72.82150704413652);
    var ab = [];
    var Lat;
    var Lan;
    var v;
    int v1;
    var v2 = [];

    final Uint8List markerIconS = await getBytesFromCanvasS(Size(100, 100));
    markes.add(Marker(
        markerId: MarkerId("START"),
        position: LatLng(22.597694985693487, 72.82150704413652),
        icon: BitmapDescriptor.fromBytes(markerIconS),
        onTap: () {
          print("Hi");
          Alert(
            context: context,
            title: 'START',
            content: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text('This is a Start position'),
                      ),
                    ],
                  ),
                ),
                /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/
              ],
            ),
          ).show();
        }));

    double x = 0,
        y = 0;
    print(markedspots.length);
    //final String markerIdVal = 'id_$_markerIdCounter';
    //final MarkerId markerId = MarkerId(markerIdVal);
    //final Marker marker = Marker();
    for (int i = 0; i < markedspots.length; i++) {
      ab.add(markedspots[i].values.toList());
      print(ab[i][5].runtimeType);
      v = ab[i][5];
      if (ab[i][5] == null) {
        v1 = 0;
        v2.add(v1);
      }
      if (ab[i][5] != null) {
        v1 = int.parse(ab[i][5]);
        v2.add(v1);
      }
      Lat = double.parse(ab[i][2]);
      Lan = double.parse(ab[i][3]);
      if (v1 >= 75) {
        markersnamesr.add(ab[i][1]);
      }
      print(markersnamesr);
      if (v1 < 50) {
        markersnamesg.add(ab[i][1]);
      }
      print(markersnamesg);
      if (v1 >= 50 && v1 < 75) {
        markersnamesy.add(ab[i][1]);
      }
      print(markersnamesy);
      if (v1 >= 60) {
        arr5.add(LatLng(Lat, Lan));
        arr6.add(Lat);
        arr6.add(Lan);
        markersnames.add(ab[i][1]);
        //arr4.add(arr3[i]);
        //arr2.add(arr[i]);
        y = (v1 * 30) / 100;
        x = x + y;
      }
      print(arr5);
      l = x;
      print(v.runtimeType);
      vals.add(v);
      vals1.add(v1);
      print(vals[i]);
      ki = i;
      if (vals[ki] == null) {
        vals[ki] = '0';
      }
      markersname = ab[i][1];
      final Uint8List markerIcon = await getBytesFromCanvas(Size(100, 100));
      markes.add(Marker(
          markerId: MarkerId(ab[i][1]),
          position: LatLng(Lat, Lan),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: () {
            marksid = ab[i][1];
            print("Hi");
            Alert(
                context: context,
                title: ab[i][1],
                content: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.info),
                            title: Text('dustbin status :- ${ab[i][5]}%'),
                          ),
                          ListTile(
                            leading: Icon(Icons.update),
                            title: Text('To Update value enter below'),
                          )
                        ],
                      ),
                    ),
                    /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                    TextField(
                      controller: id,
                      decoration: InputDecoration(
                        labelText: 'Enter value...',
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      marksid = ab[i][1];
                      addValue();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }));
      //print(markes);
      print(ab[i]);
      lastId = int.parse(ab[i][4]);
      print(lastId);
    }
    if (lastId == null) {
      lastId = 1;
    }
    print(lastId);
    if (lastId >= 1) {
      lastId++;
      print(lastId);
      _markerIdCounter = lastId;
    }

    /*final Uint8List markerIconE = await getBytesFromCanvasE(Size(100, 100));
    markes.add(Marker(
        markerId: MarkerId("STOP"),
        position: LatLng(22.60339496444128, 72.82169546931982),
        icon: BitmapDescriptor.fromBytes(markerIconE),
        onTap: () {
          print("Hi");
          Alert(
            context: context,
            title: 'STOP',
            content: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text('This is a Stop position'),
                      ),
                    ],
                  ),
                ),
                /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/
              ],
            ),
          ).show();
        }));*/

    print(_markerIdCounter);

    //print(markes);
    setState(() {
      allMarker = markes;
    });
    print(allMarker.length);
    for (int j = 1; j < v2.length; j++) {
      print(j);
      if (v2[j] >= 85) {
        counts++;
      }
    }
    //arr5.add(LatLng(22.60339496444128, 72.82169546931982));
    print(counts);
    if (markersnamesr == null) {
      markersnames.add('No dustbins in this range');
    }
    if (markersnamesg == null) {
      markersnames.add('No dustbins in this range');
    }
    if (markersnamesy == null) {
      markersnames.add('No dustbins in this range');
    }
    if (markersnames == null) {
      markersnames.add('No dustbins in this range');
    }
    jp = 0;
    if (counts >= 1) {
     xyz();
    }
    print(arr6);
    arr9.clear();
    for (int m = 0; m < arr6.length; m++) {
      arr9.add(arr6[m]);
    }
    if (temps > 1) {
      if (_isFavorited == false) {
        calcDistance();
      }
    }
    /*Future.delayed(Duration(seconds: 1), () {
      return Navigator.pop(context); //pop dialog
    });*/
    //markes.clear();
    //markes.add(Marker());
    //allMarker = markedspots;
  }


  Future<void> _add() async {
    //final Uint8List markerIcon = await getBytesFromAsset('assets/images/bin1.png', 100);
    //final Uint8List markerIcon = await getBytesFromCanvas(Size(100,100), 'assets/images/bin1.png');
    //final Uint8List markerIcon = await getBytesFromCanvas(Size(100, 100));
    //final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon));
    final String markerIdVal = markername.text;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: pos1,
      //infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      /*onTap: () {
          Alert(
              context: context,
              title: markerIdVal,
              content: Column(
                children: <Widget>[
                  Container(
                    //child: Text('${value[0]['id_4']}%'),
                  ),
                  /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                  TextField(
                    controller: id1,
                    decoration: InputDecoration(
                      labelText: 'Enter value...',
                    ),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  onPressed: () {
                    addValue();
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
          //_onMarkerTapped(markerId);
          //print("tapped");
        },*/
    );
    //print(marker);
    //allMarker.add(marker);
    print(allMarker);
    markersname = markerId.value;
    final Uint8List markerIcon1 = await getBytesFromCanvasN(Size(100, 100));
    allMarker.add(
      Marker(
          markerId: markerId,
          position: pos1,
          icon: BitmapDescriptor.fromBytes(markerIcon1),
          onTap: () {
            _onMarkerTapped(markerId);
            marksid = markerId.value;
            print(markerId);

            Alert(
                context: context,
                title: markerIdVal,
                content: Column(
                  children: <Widget>[
                    Container(
                      //child: Text('${value[0]['id_4']}%'),
                    ),
                    /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                    TextField(
                      controller: id,
                      decoration: InputDecoration(
                        labelText: 'Enter value...',
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      addValue();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }),
    );
    lat = pos1.latitude;
    print(lat);
    long = pos1.longitude;
    print(long);
    markId = markerIdVal;
    print(ln);
    //markId[ln].add(markerIdVal);
    //ln++;
    //print(markId);
    //markedspots = allMarker;
    setState(() {
      markers[markerId] = marker;
    });
    updateMarker();
    updateTable();
    print("...");
    //print(markedspots);
    _markerIdCounter++;
    onClear();
    _onLoading();
    //_fetchMarker();
  }

  /*void valueadd(){
    print(pos1);
    Alert(
        context: context,
        title: "Admin Building",
        content: Column(
          children: <Widget>[
            Container(
              //child: Text('${value[0]['id_4']}%'),
            ),
            /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

            /* TextField(
                    controller: id4,
                    decoration: InputDecoration(
                      labelText: 'Enter value...',
                    ),
                  ),*/
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {

            },
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }*/

  var l;
  var arr2 = [];
  var arr4 = [];
  List<LatLng> arr5 = [];

  Future route() async {
    //print(arr);
    double t = 0;
    double x = 0;
    double y = 0;
    //var z = int.parse(arr[0]);
    print("Hi");
    //print(arr);
    print(arr);
    print(x);
    print(y);
    print(arr[0]);
    print(arr3);
    //print(z);
    //print(z.runtimeType);
    //var j = int.parse(z);
    //t = x*y;
    //t = (j*x)/100;
    print(t);
    print(arr[3]);
    for (int i = 0; i < arr.length; i++) {
      print(arr[i]);
      var z = arr[i];
      //var b = arr3[i];
      var j = int.parse(z);
      if (j >= 75) {
        arr5.add(latlang[i]);
        arr4.add(arr3[i]);
        arr2.add(arr[i]);
        y = (j * 30) / 100;
        x = x + y;
      }
      print(arr2);
      print(arr5);
      print(arr4);
      print(x);
      l = x;
      print(l);
      //print(arr[i]);
    }
    /*setState(() {
      for(int i=0;i<allMarker.length;i++){
        latlngSegment1.add(arr5[i]);
      }
    });
    print(".............");
    print(latlngSegment1);*/
    getIt();
  }

  void getIt() {
    Alert(
      context: context,
      title: "Route",
      content: Column(
        children: <Widget>[
          Container(
            child: Text('${l}L'),
          ),
          Container(
            child: Text('${arr4}:${arr2}'),
          ),
          /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/
        ],
      ),
    ).show();
    var z = arr2.length;
    //print(j);
    arr4.removeRange(0, z);
    print(arr4);
    arr2.removeRange(0, z);
    print(arr2);
    setState(() {});
    poly();
  }

  //for(int i=0;i<allMarker.length;i++){
  //latlang.add(_mark1);
  //}
  int poli = 0;

  void poly() {
    poli++;
    //initState();
    setState(() {
      //latlang.add(arr5[0]);
      //latlang.add(_mark3);
      //print(allMarker);
      /*for(int i=0;i<allMarker.length;i++){
        latlang.add(arr5[i]);
      }*/
    });
    //print(arr5);
    //print(latlang);
    _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        geodesic: true,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap,
        patterns: [PatternItem.gap(10), PatternItem.dot],
        //latlng is List<LatLng>
        points: arr8,
        width: 10,
        color: Colors.blue,
        onTap: () {}));
  }

  void removePoly() {
    poli = 0;
    _polyline.clear();
    //_fetchMarker();
  }

  double totalDistance = 0;
  var arr7 = [];
  var arr10 = [];
  List<LatLng> arr8 = [];

  double n;
  int n1 = 0;
  List<List<double>> arr11 = List<List<double>>();
  List completed = List();
  double distance = 0;

  void takeInput() {
    n = arr6.length / 2;
    n1 = n.toInt();
    print('$n...............');
    double calculateDistance(lat1, lon1, lat2, lon2) {
      print('$lat1,$lon1,$lat2,$lon2');
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    for (var i = 0; i < 10; i++) {
      print(i);
      List<double> list = List<double>();
      for (var j = 0; j < 10; j++) {
        print(j);
        list.add(j.toDouble());
      }
      arr11.add(list);
    }
    double a1 = 0;
    int a2 = 0;
    double a3 = 0;
    int a4 = 0;
    print(arr6.length / 2);
    print(arr5);
    for (int i = 0; i < arr6.length; i++) {
      print(i);
      a1 = i / 2;
      a2 = a1.toInt();
      print('$a2............');
      for (int j = 0; j < arr6.length; j++) {
        a3 = j / 2;
        print('$a3............');
        a4 = a3.toInt();
        print('$a4............');
        /*if(j == 0){
          distance = calculateDistance(arr6[i], arr6[i+1], arr6[j], arr6[j+1]);
        }
        if(j > 0){
          distance = calculateDistance(arr6[i+2], arr6[i+3], arr6[j+2], arr6[j+3]);
        }*/
        distance =
            calculateDistance(arr6[i], arr6[i + 1], arr6[j], arr6[j + 1]);
        arr11[a2][a4] = distance;
        print(arr11[a2][a4]);
        print('0000000000000000');
        //print(completed[i]);
        j++;
      }
      i++;
    }
    completed.clear();
    for (int k = 0; k < arr6.length / 2; k++) {
      completed.add(0);
    }
    print(completed);
    print(arr11);
    for (int i = 0; i < 10; i++) {
      print(i);
      print('\n');
      for (int j = 0; j < 10; j++) {
        print(j);
        print(arr11[i][j]);
      }
    }
  }

  double cost1 = 0;

  int least(int c) {
    print('least');
    int i,
        nc = 999;
    double min = 999;
    double kmin;
    for (i = 0; i < arr6.length / 2; i++) {
      print('--------------------------------');
      print(i);
      print(arr11[c][i]);
      print(completed[i]);
      if ((arr11[c][i] != 0) &&
          (completed[i] == 0)) if (arr11[c][i] + arr11[i][c] < min) {
        min = arr11[i][0] + arr11[c][i];
        print(arr11[c][i]);
        kmin = arr11[c][i];
        nc = i;
        print('nc: $nc');
      }
    }
    print(cost1);
    print(nc);
    print(kmin);
    if (min != 999) {
      cost1 = cost1 + kmin;
    }
    print(cost1);
    return nc;
  }

  List<String> markersinRoute = [];
  List<int> jail = [];

  void mincost(int city) {
    //jail++;
    print('mincost');
    int i, ncity;
    completed[city] = 1;
    print('${city + 1}--->');
    print(arr5[city]);
    arr8.add(arr5[city]);
    markersinRoute.add('${markersnames[city]}\n');
    /*if(ip > 0){

    }*/
    //ip++;
    ncity = least(city);
    print(ncity);
    if (ncity == 999) {
      ncity = 0;
      //cout<<ncity+1;
      cost1 += arr11[city][ncity];
      return;
    }
    //jail[city]=city;
    mincost(ncity);
  }

  int ip;

  void calcDistance() {
    ip = 0;
    //jail.clear();
    //jail=0;
    arr8.clear();
    arr6.clear();
    markersinRoute.clear();
    for (int i = 0; i < arr9.length; i++) {
      arr6.add(arr9[i]);
    }
    arr6.reversed;
    takeInput();
    mincost(0);
    print('$jail..............');
    print(markersnames);
    print(markersnames.length);
    print(arr5.length);
    arr8.add(LatLng(22.597694985693487, 72.82150704413652));
    poly();
  }

  /*void calcDistance() {
    //arr6 = arr9;
    print(arr9);
    poli++;
    arr8.clear();
    arr7.clear();
    arr6.clear();
    for(int i=0;i<arr9.length;i++){
      arr6.add(arr9[i]);
    }
    totalDistance = 0;
    //print("inside");
    print(arr6);
    double lat3;
    double lan3;
    double lat4;
    double lan4;
    double calculateDistance(lat1, lon1, lat2, lon2) {
      print('$lat1,$lon1,$lat2,$lon2');
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    double calculateDistance1(lat1, lon1, lat2, lon2) {
      print('$lat1,$lon1,$lat2,$lon2');
      lat4 = lat2;
      lan4 = lon2;
      print('$lat4,$lan4');
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }
    double distance2 = 0;
    double distance3 = 0;
    int pl = 0;
    double calculateDistance2(lat1, lon1, lat2, lon2) {
      print('$lat1,$lon1,$lat2,$lon2');
      if(pl == 1){
        lat3 = lat1;
        lan3 = lon1;
      }
      //print('$lat4,$lan4');
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    arr7.add(22.597694985693487);
    arr7.add(72.82150704413652);
    arr8.add(LatLng(22.597694985693487, 72.82150704413652));
    double distance = 0;
    double distance1 = calculateDistance1(arr6[0], arr6[1], arr6[2], arr6[3]);
    print(distance1);
    print("llllllllllllllllllllllllllllllllllllllll");
    print(arr6.length);
    double h = 1;
    double loop = (arr6.length)/2;
    if(arr6.length/2 >= 6){
      h = (arr6.length/2)-6;
      loop = loop + pow(2,h);
    }


    print(loop);
    for (int i = 0; i < arr6.length-2; i++) {
      //print(i);
      //print(arr6.length);
      distance1 = calculateDistance1(arr6[i], arr6[i+1], arr6[i+2], arr6[i+3]);
      //print(distance1);
      for (int j = i + 2; j < (arr6.length); j++) {
        //print(j);
        //print(arr6.length);
        //distance2 = calculateDistance2(arr6[j], arr6[j + 1], 22.60339496444128, 72.82169546931982);
        distance = calculateDistance(arr6[i], arr6[i + 1], arr6[j], arr6[j + 1]);

        //print(distance);
        //distance1 = distance;
        //print(distance);
        if (distance < distance1) {
          lat3 = arr6[j];
          lan3 = arr6[j + 1];
          //print(lat3);
          //print("yes it is less");
          //print(lan3);
          distance1 = distance;
          //print(distance1);
        }
        /*if(f == 1){
          distance3 = distance2;
          print('0000000000000000');
          print(distance3);
        }
        if(distance2 >= distance3){
          lat3 = arr6[i];
          lan3 = arr6[i + 1];
          distance3 = distance2;
          print('11111111111111111');
          print(distance3);
        }*/
        j++;
        //print(distance);
      }
      arr10.clear();
      arr6.clear();
      //print(lat3);
      //print(lan3);
      if(lat3 == arr7[arr7.length-2]) {
        //print(lat4);
        //print(lan4);
        lat3 = lat4;
        lan3 = lan4;
        //print('$lat3////');
        //print('$lan3////');
      }
      arr8.add(LatLng(lat3, lan3));
      //print('()$arr8');
      arr7.add(lat3);
      arr7.add(lan3);
      //print(arr7);
      //print(",,,,");
      for (int l = 0; l < arr7.length; l++) {
        //print(arr7[l]);
        arr10.add(arr7[l]);
        //print(arr10[l]);
      }
      //print(arr10.length);
      //print(arr9);
      //print(arr9.length);
      for (int a = 0; a < arr9.length; a++) {
        //print('$a*');
        arr6.add(arr9[a]);
      }
      //print(arr6);
      arr6.removeWhere((item) => arr10.contains(item));

      for (int k = 0; k < arr6.length; k++) {
        //print('$k-');
        arr10.add(arr6[k]);
      }
      arr6.clear();
      //print(arr6);
      arr10 = Set.of(arr10).toList();
      arr10.toSet().toList();
      //print(arr10);
      //print(arr10.length);
      for (int p = 0; p < arr10.length; p++) {
        //print('$p.');
        arr6.add(arr10[p]);
        //print(arr6);
      }
      //arr7.add(arr6);
      //arr6 = arr10;
      //print(arr6);
      i++;
      //print(distance);
      //break;
    }

    /*arr8.clear();
    arr7.clear();
    arr7.add(22.597694985693487);
    arr7.add(72.82150704413652);
    arr8.add(LatLng(22.597694985693487, 72.82150704413652));
    print('.....$arr6');
    print('.....$arr7');
    print(arr8);
    int f;
    print(arr6.length-1);

    for(int i=2;i<arr6.length-2;i++){
      f = 0;
      pl = 0;
      print(i);
      for(int j=i;j<=i+2;j++){
        f++;
        pl++;
        print(j);
        distance2 = calculateDistance2(arr6[j], arr6[j + 1], 22.60339496444128, 72.82169546931982);
        print(distance2);
        if(f == 1){
          distance3 = distance2;
          print('0000000000000000');
          print(distance3);
        }
        if(distance2 > distance3){
          lat3 = arr6[j];
          lan3 = arr6[j + 1];
          distance3 = distance2;
          print('11111111111111111');
          print(distance3);
        }
        j++;
      }
      arr10.clear();
      arr6.clear();
      print(lat3);
      //print(lat3);
      //print(lan3);
      /*if(lat3 == arr7[arr7.length-2]) {
        print(lat4);
        print(lan4);
        lat3 = lat4;
        lan3 = lan4;
        //print('$lat3////');
        //print('$lan3////');
      }*/
      arr8.add(LatLng(lat3, lan3));
      print(arr8);
      //print('()$arr8');
      arr7.add(lat3);
      arr7.add(lan3);
      print(arr7);
      //print(",,,,");
      for (int l = 0; l < arr7.length; l++) {
        //print(arr7[l]);
        arr10.add(arr7[l]);
        //print(arr10[l]);
      }
      //print(arr10.length);
      //print(arr9);
      //print(arr9.length);
      for (int a = 0; a < arr9.length; a++) {
        //print('$a*');
        arr6.add(arr9[a]);
      }
      //print(arr6);
      arr6.removeWhere((item) => arr10.contains(item));

      for (int k = 0; k < arr6.length; k++) {
        //print('$k-');
        arr10.add(arr6[k]);
      }
      arr6.clear();
      //print(arr6);
      arr10 = Set.of(arr10).toList();
      arr10.toSet().toList();
      //print(arr10);
      //print(arr10.length);
      for (int p = 0; p < arr10.length; p++) {
        //print('$p.');
        arr6.add(arr10[p]);
        //print(arr6);
      }
      //arr7.add(arr6);
      //arr6 = arr10;
      print(arr6);
      i++;
    }

    /*arr8.clear();
    arr7.clear();
    arr7.add(22.597694985693487);
    arr7.add(72.82150704413652);
    arr8.add(LatLng(22.597694985693487, 72.82150704413652));
    for(int i=2;i<arr6.length-2;i++){
      f = 0;
      pl = 0;
      print(i);
      for(int j=i;j<=i+2;j++){
        f++;
        pl++;
        print(j);
        distance2 = calculateDistance1(arr6[j], arr6[j + 1], 22.60339496444128, 72.82169546931982);
        print(distance2);
        if(f == 1){
          distance3 = distance2;
          print('0000000000000000');
          print(distance3);
        }
        if(distance2 > distance3){
          lat3 = arr6[j];
          lan3 = arr6[j + 1];
          distance3 = distance2;
          print('11111111111111111');
          print(distance3);
        }
        j++;
      }
      arr10.clear();
      arr6.clear();
      print(lat3);
      //print(lat3);
      //print(lan3);
      /*if(lat3 == arr7[arr7.length-2]) {
        print(lat4);
        print(lan4);
        lat3 = lat4;
        lan3 = lan4;
        //print('$lat3////');
        //print('$lan3////');
      }*/
      arr8.add(LatLng(lat3, lan3));
      print(arr8);
      //print('()$arr8');
      arr7.add(lat3);
      arr7.add(lan3);
      print(arr7);
      //print(",,,,");
      for (int l = 0; l < arr7.length; l++) {
        //print(arr7[l]);
        arr10.add(arr7[l]);
        //print(arr10[l]);
      }
      //print(arr10.length);
      //print(arr9);
      //print(arr9.length);
      for (int a = 0; a < arr9.length; a++) {
        //print('$a*');
        arr6.add(arr9[a]);
      }
      //print(arr6);
      arr6.removeWhere((item) => arr10.contains(item));

      for (int k = 0; k < arr6.length; k++) {
        //print('$k-');
        arr10.add(arr6[k]);
      }
      arr6.clear();
      //print(arr6);
      arr10 = Set.of(arr10).toList();
      arr10.toSet().toList();
      //print(arr10);
      //print(arr10.length);
      for (int p = 0; p < arr10.length; p++) {
        //print('$p.');
        arr6.add(arr10[p]);
        //print(arr6);
      }
      //arr7.add(arr6);
      //arr6 = arr10;
      print(arr6);
      i++;
    }*/




    //print(arr6[arr6.length-2]);
    arr8.add(LatLng(arr6[arr6.length-2],arr6[arr6.length-1]));*/





    print(arr5);
    print(distance);
    print(arr6.length);
    /*for (int i = 0; i <= (arr6.length / 2); i++) {
      print(i);
      totalDistance +=
          calculateDistance(arr6[i], arr6[i + 1], arr6[i + 2], arr6[i + 3]);
      //print(totalDistance);
      i++;
    }*/
    //totalDistance += calculateDistance(arr6[0], arr6[1], arr6[2], arr6[3]);
    /*for(var i = 0; i < arr6.length-1; i+2){
      /*totalDistance += calculateDistance(arr6[i], arr6[i+1], arr6[i+2], arr6[i+3]);
      i++;
      print(totalDistance);*/
      print(i);
    }*/
    //print(totalDistance);
    arr7.add(22.60339496444128);
    arr7.add(72.82169546931982);
    arr8.add(LatLng(22.60339496444128, 72.82169546931982));
    arr8 = Set.of(arr8).toList();
    print(arr8);
    //arr6 = arr9;
    poly();
  }*/

  /*double distance(
      double lat1, double lon1, double lat2, double lon2) {
    double theta = lon1 - lon2;
    double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
    dist = acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    dist = dist * 1.609344;

    return dist;
  }

  double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  double rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }

  void calcDistance() {
    //print("Distance : " + distance(32.9697, -96.80322, 29.46786, -98.53506, 'K'));
    double totalDistance = 0;
    print(arr6.length);
    for(int i=0;i<=(arr6.length/2);i++){
      print(i);
      totalDistance += distance(arr6[i], arr6[i+1], arr6[i+2], arr6[i+3]);
      print(totalDistance);
      i++;
    }
    print(totalDistance);
  }*/
  //final value = 70;
  //@override
  /*void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/images/Bin.png')
        .then((onValue) {
      setState(() {
        myIcon = onValue;
      });
    });

    super.initState();
    //getIt();
    var j = arr5.length;
    print(j);
    arr5.removeRange(0,j);
    print(arr5);
    print(".............");
    /*for(int i=0;i<allMarker.length;i++){
      latlang.add(arr5[i]);
    }*/
    //
    //latlang.add(_mark1);
    //latlang.add(_mark2);
    //print(latlngSegment1);
    allMarker.add(
      Marker(
          markerId: markerId1,
          position: _mark1,
          icon: myIcon,
          onTap: () {
            _fetchString();
            //CustomDialog(context);
            Alert(
                context: context,
                title: "Admin Building",
                content: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${value[0]['id_1']}%',
                        //: Icon(Icons.delete),
                      ),
                    ),
                    /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                    TextField(
                      controller: id1,
                      decoration: InputDecoration(
                        labelText: 'Enter value...',
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: addValue,
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }),
    );
    /*allMarker.add(Marker(
        markerId: markerId1,
        position: _mark1,
        icon: myIcon,
        onTap: (){
          _fetchString();
          //CustomDialog(context);
          Alert(
              context: context,
              title: "Admin Building",
              content: Column(
                children: <Widget>[
                  Container(
                    child: Text(value[0]['id_1']),

                  ),
                  /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter value...',
                    ),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        }
    ),);*/
    allMarker.add(
      Marker(
          markerId: markerId2,
          position: _mark2,
          icon: myIcon,
          onTap: () {
            _fetchString();
            //CustomDialog(context);
            Alert(
                context: context,
                title: "Admin Building",
                content: Column(
                  children: <Widget>[
                    Container(
                      child: Text('${value[0]['id_2']}%'),
                    ),
                    /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                    TextField(
                      controller: id2,
                      decoration: InputDecoration(
                        labelText: 'Enter value...',
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      addValue();
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }),
    );
    allMarker.add(
      Marker(
          markerId: markerId3,
          position: _mark3,
          icon: myIcon,
          onTap: () {
            _fetchString();
            //CustomDialog(context);
            Alert(
                context: context,
                title: "Admin Building",
                content: Column(
                  children: <Widget>[
                    Container(
                      child: Text('${value[0]['id_3']}%'),
                    ),
                    /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter value...',
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      addValue();
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }),
    );
    allMarker.add(
      Marker(
          markerId: markerId4,
          position: _mark4,
          icon: myIcon,
          onTap: () {
            _fetchString();
            //CustomDialog(context);
            Alert(
                context: context,
                title: "Admin Building",
                content: Column(
                  children: <Widget>[
                    Container(
                      child: Text('${value[0]['id_4']}%'),
                    ),
                    /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                    TextField(
                      controller: id4,
                      decoration: InputDecoration(
                        labelText: 'Enter value...',
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      addValue();
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }),
    );
  }*/

  /*Completer<GoogleMapController> _controller = Completer();
  //BitmapDescriptor dustbinIcon;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.599588, 72.820503),
    zoom: 17,
  );
  static const LatLng _mark1 = const LatLng(22.599588, 72.820503);
  static MarkerId markerId1 = MarkerId("1");
  static const LatLng _mark2 = const LatLng(22.600028, 72.820945);
  static MarkerId markerId2 = MarkerId("2");
  static const LatLng _mark3 = const LatLng(22.600706, 72.820355);
  static MarkerId markerId3 = MarkerId("3");
  static const LatLng _mark4 = const LatLng(22.599365, 72.819376);
  static MarkerId markerId4 = MarkerId("4");
  static const LatLng _mark5 = const LatLng(22.602730, 72.821262);
  static MarkerId markerId5 = MarkerId("5");
  static var value = 70;
  /*showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Alert Message Title Text.'),
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
    );
  }*/
  /*Future<void> createMarkerImageFromAsset(BuildContext,context)async{
    final ImageConfiguration imageConfiguration = createLocalImageConfiguration(context);
    var bitmap = await BitmapDescriptor.fromAssetImage(imageConfiguration, 'charusat.jpg');
  }*/
  _showBottomsheet(context){
    showModalBottomSheet(context: context, builder: (BuildContext context){return Container();});
  }

  Set<Marker> _markers = {
    Marker(
        markerId: markerId1,
        position: _mark1,
        onTap: ()=>_showBottomsheet(context);
        /*infoWindow: InfoWindow(
          title: 'Admin',
          snippet: 'value',
        )*/
    ),
    Marker(
        markerId: markerId2,
        position: _mark2,
        infoWindow: InfoWindow(
          title: 'IIIM',
          snippet: 'Inducesmile.com',
        )
    ),
    Marker(
        markerId: markerId3,
        position: _mark3,
        infoWindow: InfoWindow(
          title: 'DEPSTAR',
          snippet: 'Inducesmile.com',
        )
    ),
    Marker(
        markerId: markerId4,
        position: _mark4,
        infoWindow: InfoWindow(
          title: 'EC/EE',
          snippet: 'Inducesmile.com',
        )
    ),
    Marker(
        markerId: markerId5,
        position: _mark5,
        infoWindow: InfoWindow(
          title: 'Hospital',
          //snippet: value,//'Inducesmile.com',
          //snippet: value,
        )
    )
  };*/
  /*@override
  void initState(){
    super.initState();
    setState(() {
      _fetchMarker();
    });
  }*/
  /*void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio:1), 'assets/images/xyz1.png')
        .then((onValue) {
      myIcon = onValue;
    });
  }*/
  //Using asset Image
  /*Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    final Paint paint = Paint()..color = Colors.blue;
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }*/
  //Using Canvas
  /*Future<Uint8List> getBytesFromCanvas(String path, int width, int height) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.blue;
    final Radius radius = Radius.circular(20.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
    /*TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: 'Hello world',
      style: TextStyle(fontSize: 25.0, color: Colors.white),
    );*/
    //painter.layout();
    //painter.paint(canvas, Offset((width * 0.5) - painter.width * 0.5, (height * 0.5) - painter.height * 0.5));
    //final img = await pictureRecorder.endRecording().toImage(width, height);
    //final data = await img.toByteData(format: ui.ImageByteFormat.png);
    //return data.buffer.asUint8List();
    //ByteData data = await rootBundle.load(path);
    ui.Image image = //await rootBundle.load(path); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        size.width.toInt(),
        size.height.toInt()
    );

  }*/
  /*Future < BitmapDescriptor > getBytesFromCanvas(Size size, urlAsset) async
  {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    //final Paint paint = Paint()..color = Colors.transparent;
    final Radius radius = Radius.circular(size.width / 2);

    //final Paint tagPaint = Paint()..color = Colors.blue;
    //final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.green.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              0.0,
              0.0,
              size.width,
              size.height
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              shadowWidth,
              shadowWidth,
              size.width - (shadowWidth * 2),
              size.height - (shadowWidth * 2)
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);
    Rect oval = Rect.fromLTWH(
        imageOffset,
        imageOffset,
        size.width - (imageOffset * 2),
        size.height - (imageOffset * 2)
    );

    // Add path for oval image
    canvas.clipPath(Path()
      ..addOval(oval));
    final ByteData datai = await rootBundle.load(urlAsset);
    //var imaged = await loadImage(new Uint8List.view(datai.buffer));
    ui.Image image = await loadImage(new Uint8List.view(datai.buffer)); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
    //canvas.drawImage(imaged, new Offset(0, 0), new Paint());
    //final img = await pictureRecorder.endRecording().toImage(size.width.toInt(),
        //size.height.toInt());
    //final data = await img.toByteData(format: ui.ImageByteFormat.png);
    //return data.buffer.asUint8List();
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        size.width.toInt(),
        size.height.toInt()
    );

    // Convert image to bytes
    final ByteData byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }
  Future < ui.Image > loadImage(List < int > img) async {
    final Completer < ui.Image > completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }*/
  int green = 0;
  int yellow = 0;
  int red = 0;

  Future<Uint8List> getBytesFromCanvas(Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Radius radius = Radius.circular(size.width / 2);

    //final Paint tagPaint = Paint()..color = Colors.blue;
    //final double tagWidth = 40.0;

    final Paint shadowPaintg = Paint()
      ..color = Colors.green.withAlpha(100);
    final Paint shadowPainty = Paint()
      ..color = Colors.yellowAccent.withAlpha(100);
    final Paint shadowPaintr = Paint()
      ..color = Colors.red.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()
      ..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;
    print(vals1[ki]);
    // Add shadow circle
    if (vals1[ki] >= 75) {
      print('red');
      canvas.drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
            bottomRight: radius,
          ),
          shadowPaintr);
      red++;
    }
    if (vals1[ki] >= 50 && vals1[ki] < 75) {
      canvas.drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
            bottomRight: radius,
          ),
          shadowPainty);
      yellow++;
    }
    if (vals1[ki] < 50) {
      canvas.drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
            bottomRight: radius,
          ),
          shadowPaintg);
      green++;
    }
    print('------');
    print(red);
    print(green);
    print(yellow);
    print('------');

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);
    print(vals[ki]);
    print(vals[ki].runtimeType);
    print(markersname.length);
    if (markersname.length >= 5) {
      markersname = markersname[0];
    }
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: '$markersname \n${vals[ki]}%',
      style: TextStyle(fontSize: 20.0, color: Colors.black),
    );
    painter.layout();
    //paintImage(canvas: canvas, rect: oval, fit: BoxFit.fitWidth);
    painter.paint(
        canvas,
        Offset((size.width * 0.5) - painter.width * 0.5,
            (size.height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  Future<Uint8List> getBytesFromCanvasN(Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Radius radius = Radius.circular(size.width / 2);

    //final Paint tagPaint = Paint()..color = Colors.blue;
    //final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()
      ..color = Colors.green.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()
      ..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);
    green++;
    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: '$markersname \n0%',
      style: TextStyle(fontSize: 25.0, color: Colors.black),
    );
    painter.layout();
    //paint(canvas: canvas, rect: oval, fit: BoxFit.fitWidth);
    painter.paint(
        canvas,
        Offset((size.width * 0.5) - painter.width * 0.5,
            (size.height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  Future<Uint8List> getBytesFromCanvasS(Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Radius radius = Radius.circular(size.width / 2);

    //final Paint tagPaint = Paint()..color = Colors.blue;
    //final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()
      ..color = Colors.green.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()
      ..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);
    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: 'START',
      style: TextStyle(fontSize: 20, color: Colors.black),
    );
    painter.layout();
    //paint(canvas: canvas, rect: oval, fit: BoxFit.fitWidth);
    painter.paint(
        canvas,
        Offset((size.width * 0.5) - painter.width * 0.5,
            (size.height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  Future<Uint8List> getBytesFromCanvasE(Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Radius radius = Radius.circular(size.width / 2);

    //final Paint tagPaint = Paint()..color = Colors.blue;
    //final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()
      ..color = Colors.red.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()
      ..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);
    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: 'STOP',
      style: TextStyle(fontSize: 25.0, color: Colors.black),
    );
    painter.layout();
    //paint(canvas: canvas, rect: oval, fit: BoxFit.fitWidth);
    painter.paint(
        canvas,
        Offset((size.width * 0.5) - painter.width * 0.5,
            (size.height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  IconData _iconData = Icons.directions_bike;
  bool closeButton = false;
  bool _isFavorited = true;
  int _favoriteCount = 41;

  bool cl;
  int jk;
  int jp = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    //_fetchString();
    //_fetchMarker();
    //final Uint8List markerIcon = await getBytesFromCanvasB(Size(100, 100));
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: GestureDetector(
                onTap: () {
                  Alert(
                      context: context,
                      title: "Chosse where to add dustbin...",
                      content: Column(
                        children: <Widget>[
                          TextField(
                            controller: markername,
                            decoration: InputDecoration(
                              labelText: 'Enter marker name...',
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            cl = true;
                            _currentLocation();
                            //_add();
                            Navigator.of(context).pop();
                            //cl = false;
                          },
                          child: Text(
                            "Current Location",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        DialogButton(
                          onPressed: () {
                            _add();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Current Tap",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]).show();
                },
                child: Icon(
                  Icons.add_location,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: GestureDetector(
                onTap: () {
                  jk = 0;
                  if (_isFavorited == true) {
                    calcDistance();
                    _currentLocation();
                  }
                  if (_isFavorited == false) {
                    removePoly();
                    _currentLocation();
                    /*setState(() {
                      super.initState();
                      _kGooglePlex = CameraPosition(
                        target: LatLng(22.60339496444128, 72.82169546931982),
                        zoom: 17,
                      );
                    });*/
                  }
                  _toggleFavorite();
                  // ignore: unnecessary_statements
                  //Icon(Icons.clear);
                },
                child: IconButton(
                  icon: (_isFavorited
                      ? Icon(
                    Icons.directions_bike,
                    color: Colors.white,
                    size: 26.0,
                  )
                      : Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 26.0,
                  )),
                  //Icons.directions_bike,
                  //size: 26.0,
                ),
              )),
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
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_forever, color: Colors.red,),
            title: Text('green', style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_sweep, color: Colors.yellow),
            title: Text('yellow', style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_outline, color: Colors.green),
            title: Text('green',style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete, color: Colors.green),
            title: Text('Search',style: TextStyle(color: Colors.black),),
          ),
        ],
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          tooltip: 'Increment',
          child: Icon(Icons.timeline),
          elevation: 2.0,
          onPressed: () {
            if (poli == 0) {
              Alert(
                title: 'About Route',
                context: context,
                content: Container(
                  height: 80,
                  color: Colors.white,
                  child: Text(
                    'No path is there to be displayed.',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
              ).show();
            }
            //print(_polyline);
            int lp = 0;
            if (poli == 1) {
              Alert(
                  title: 'Route has total ${arr8.length - 2} stops.',
                  context: context,
                  content: SingleChildScrollView(
                    child: Container(
                      height: 200,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: markersinRoute.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text('$index. ${markersinRoute[index]}');
                          }),
                      /*Row(
                              children: <Widget>[
                                Card(
                                  child: Text(
                                    '$totalDistance Km',
                                    style: TextStyle(fontSize: 23),
                                  ),
                                )
                              ],
                            )*/

                    ),
                  )).show();
            }
          }),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox.fromSize(
                                size: Size(56, 56), // button width and height
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.white, // button color
                                    child: InkWell(
                                      //splashColor: Colors.green, // splash color
                                      onTap: () {}, // button pressed
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.delete_forever, color: Colors.red,),
                                                //Text('Dustbins filled >= 75', style: TextStyle(color: Colors.black),),
                                              ]
                                          ),
                                          // icon
                                          // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),
                        Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('$markersnamesr',style: TextStyle(fontSize: 25,color: Colors.red),),
                            ]
                        ),
                      ]
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                  mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                          SizedBox.fromSize(
                            size: Size(56, 56), // button width and height
                            child: ClipOval(
                              child: Material(
                                color: Colors.white, // button color
                                child: InkWell(
                                  //splashColor: Colors.green, // splash color
                                  onTap: () {}, // button pressed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.delete_sweep, color: Colors.yellow),
                                      //Text('Dustbins filled >= 50 but < 75', style: TextStyle(color: Colors.black),),  // text
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
            ],
                        ),
                        Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('$markersnamesy',style: TextStyle(fontSize: 25,color: Colors.yellow),),
                            ]
                        ),
                      ]
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox.fromSize(
                                size: Size(56, 56), // button width and height
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.white, // button color
                                    child: InkWell(
                                      //splashColor: Colors.green, // splash color
                                      onTap: () {}, // button pressed
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          // text
                                          Icon(Icons.delete_outline, color: Colors.green),
                                          //Text('Filled < 50',style: TextStyle(color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),
                        Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('$markersnamesy',style: TextStyle(fontSize: 25,color: Colors.green),),
                            ]
                        ),
                      ]
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column( mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox.fromSize(
                                size: Size(56, 56), // button width and height
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.white, // button color
                                    child: InkWell(
                                      //splashColor: Colors.green, // splash color
                                      onTap: () {}, // button pressed
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.delete, color: Colors.green),
                                          Text('${l}L',style: TextStyle(color: Colors.black),), // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]
                              ),
                        Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('$markersnames',style: TextStyle(fontSize: 25,color: Colors.green,),),
                            ]
                        ),
                      ]
                  ),
                  //IconButton(icon: Icon(Icons.delete_forever, color: Colors.red),),
                  //IconButton(icon: Icon(Icons.delete_sweep, color: Colors.yellow),),
                  /*Icon(Icons.delete_forever, color: Colors.red),
            Text('$red', style: TextStyle(color: Colors.black),),
            Icon(Icons.delete_sweep, color: Colors.yellow),
            Text('$yellow', style: TextStyle(color: Colors.black),),*/
                ],
              ),
              /*child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(markersnames[1],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 24.0,
                  ),
                ),
              ),*/
            );
          });
        },
        //shape: CircleBorder(side: CircularNotchedRectangle()),
        tooltip: 'Increment',
        child: Icon(Icons.keyboard_arrow_up),
        elevation: 2.0,
      ),*/
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        notchMargin: 2.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox.fromSize(
              size: Size(56, 56), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    //splashColor: Colors.green, // splash color
                    onTap: () {
                      Alert(
                          title: 'Dustbin filled >= 75%',
                          context: context,
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[Text('$markersnamesr')],
                            ),
                          )).show();
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete_forever, color: Colors.red),
                        // icon
                        Text(
                          '$red',
                          style: TextStyle(color: Colors.black),
                        ),
                        // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(56, 56), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    //splashColor: Colors.green, // splash color
                    onTap: () {
                      Alert(
                          title: 'Dustbin filled >= 50% but < 75%',
                          context: context,
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[Text('$markersnamesy')],
                            ),
                          )).show();
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete_sweep, color: Colors.yellow),
                        Text(
                          '$yellow',
                          style: TextStyle(color: Colors.black),
                        ),
                        // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(56, 56), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    //splashColor: Colors.green, // splash color
                    onTap: () {
                      Alert(
                          context: context,
                          title: 'Dustbin filled < 50%',
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[Text('$markersnamesg')],
                            ),
                          )).show();
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // text
                        Icon(Icons.delete_outline, color: Colors.green),
                        Text(
                          '$green',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(56, 56), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    //splashColor: Colors.green, // splash color
                    onTap: () {
                      Alert(
                          title: 'Dustins used in route.',
                          context: context,
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[Text('$markersnames')],
                            ),
                          )).show();
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete, color: Colors.green),
                        Text(
                          '${l}L',
                          style: TextStyle(color: Colors.black),
                        ),
                        // text
                      ],
                    ),
                  ),
                ),
              ),
            )

            //IconButton(icon: Icon(Icons.delete_forever, color: Colors.red),),
            //IconButton(icon: Icon(Icons.delete_sweep, color: Colors.yellow),),
            /*Icon(Icons.delete_forever, color: Colors.red),
            Text('$red', style: TextStyle(color: Colors.black),),
            Icon(Icons.delete_sweep, color: Colors.yellow),
            Text('$yellow', style: TextStyle(color: Colors.black),),*/
          ],
        ),
        //currentIndex: 0, // this will be set when a new tab is tapped
        //type: BottomNavigationBarType.fixed,
        /*items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_forever, color: Colors.red,),
            title: Text('$red', style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_sweep, color: Colors.yellow),
            title: Text('$yellow', style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_outline, color: Colors.green),
            title: Text('$green',style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete, color: Colors.green),
            title: Text('${l}L',style: TextStyle(color: Colors.black),),
          ),
        ],*/
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: GoogleMap(
            polylines: _polyline,
            markers: allMarker,
            //markers: Set<Marker>.from(markers.values),
            onTap: (pos) {
              pos1 = pos;
              //print(allMarker[14]);
              print(pos1);
              pos2 = pos;
              //print(pos);
              //print(mark);
              //valueadd();
              /*for(int i=0;i<mark.length;i++){
                print(mark[i]);
                if(pos1 == mark[i]){
                  print("HI");
                  valueadd();
                }
              }*/
              //valueadd();
              /*Alert(
                      context: context,
                      title: "Admin Building",
                      content: Column(
                        children: <Widget>[
                          Container(
                            /*child: Text(
                      '${value[0]['id_1']}%',
                      //: Icon(Icons.delete),
                    ),*/
                          ),
                          /*TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.delete),
                      //suffixText: '$value',
                    ),
                  ),*/

                          TextField(
                            controller: id,
                            decoration: InputDecoration(
                              labelText: 'Enter value...',
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: addValue,
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]).show();*/
            },
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (controller) {
              myController.complete(controller);
              _onLoading();
              //_fetchMarker();
            }),
      ),

      /*body: Center(
        child: SingleChildScrollView(
        child: Container(
        child: Center(
        child: Column(children: <Widget>[
      Container(
        child: GoogleMap(
          markers: Set.from(allMarker),
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            myController = controller;
          });
        },
      ),
    ),
    ],
        ),
        ),
        ),
        ),
      ),*/

      /*body: Column(

        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 566,
            width: size.width,
            child: GoogleMap(
              markers: Set.from(allMarker),
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller){
                setState(() {
                  myController = controller;
                });
              }
            ),
          )
        ],
      ),*/
      /*body: GoogleMap(
        markers: _markers,
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),*/
      /*body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(children: <Widget>[
                Container(
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                /*Container(
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
                                  builder: (_) => AlertDialog(
                                    title: Text("No.1"),
                                    content: Text("Filled Up: 70%"),
                                  ));
                            },
                            child: Icon(Icons.delete,
                                color: Colors.blue, size: 10.0),
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
                                  builder: (_) => AlertDialog(
                                    title: Text("No.2"),
                                    content: Text("Filled Up: 70%"),
                                  ));
                            },
                            child: Icon(Icons.delete,
                                color: Colors.blue, size: 10.0),
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
                                  builder: (_) => AlertDialog(
                                    title: Text("No.3"),
                                    content: Text("Filled Up: 70%"),
                                  ));
                            },
                            child: Icon(Icons.delete,
                                color: Colors.blue, size: 10.0),
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
                                  builder: (_) => AlertDialog(
                                    title: Text("No.4"),
                                    content: Text("Filled Up: 70%"),
                                  ));
                            },
                            child: Icon(Icons.delete,
                                color: Colors.blue, size: 10.0),
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
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            //title: Text("Route"),
                            content: Text("This is my content"),
                          ));
                    },
                  ),
                ),*/
              ]),
            ),
          ),
        ),
      ),*/

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
      drawer: Container(
          width: 200,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text("Admin"),
                  trailing: Icon(Icons.arrow_back),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                UserAccountsDrawerHeader(
                  accountName: Text(
                    '${username.toUpperCase()}',
                    style: TextStyle(fontSize: 28),
                  ),
                  accountEmail: null,
                  currentAccountPicture: CircleAvatar(
                    child: GestureDetector(
                      child: Text(
                        '${username[0].toUpperCase()}',
                        style: TextStyle(fontSize: 40),
                      ),
                      onTap: () {
                        CustomDialog(context);
                        /*Alert(
              context: context,
              title: "Info",
              desc: '$username')
              .show();*/
                      },
                    ),
                    backgroundColor: Theme
                        .of(context)
                        .primaryColorDark,
                    foregroundColor: Theme
                        .of(context)
                        .canvasColor,
                  ),
                ),
                ListTile(
                  title: Text("notifications"),
                  trailing: Stack(
                      children: <Widget>[
                        new Icon(Icons.mail),
                        new Positioned( // draw a red marble
                          top: -1.0,
                          right: -1.0,
                          child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 15.0, color: Colors.blue),
                              new Positioned(
                                top: 1.0,
                                right: 3.0,
                                child: Text('$jp',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                        )
                      ]
                  ), //Icon(Icons.mail),
                  onTap: () {
                    if (counts == 0) {
                      Alert(
                          context: context,
                          title: 'Notification',
                          content: Container(
                            child: Text('No notifications...'),
                          )
                      ).show();
                    }
                    if (counts == 1) {
                      Alert(
                          context: context,
                          title: 'Notification',
                          content: Container(
                            child: Text(
                                '$counts dustbin is filled more than 85%.'),
                          )
                      ).show();
                    }
                    if (counts > 1) {
                      Alert(
                          context: context,
                          title: 'Notification',
                          content: Container(
                            child: Text(
                                '$counts dustbins are filled more than 85%.'),
                          )
                      ).show();
                    }
                  },
                ),
                ListTile(
                  title: Text("New User"),
                  trailing: Icon(Icons.person),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/new');
                  },
                ),
                ListTile(
                  title: Text("Users"),
                  trailing: Icon(Icons.list),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/list');
                  },
                ),
                ListTile(
                  title: Text("Info"),
                  trailing: Icon(Icons.info_outline),
                  onTap: () {
                    //Navigator.pushReplacementNamed(context, '/list');
                    Alert(
                        buttons: null, //isCloseButton: false,
                        context: context,
                        title: "User Manual",
                        content: Container(
                          height: 200,
                          width: 300,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text("About App"),
                                  leading: Icon(Icons.info_outline),
                                ),
                                ListTile(
                                  title: Text(
                                      "These application will help to get the route to collect the garbage. These application work on the basis of dustbin filled declared using %. If the dustbin filled value is >= 65% then they will include in the route."),
                                ),
                                ListTile(
                                  title: Text(
                                      "It is Used to place marker at new dustbin location."),
                                  leading: Icon(Icons.add_location),
                                ),
                                ListTile(
                                  title: Text(
                                      "To get the route to collect garbage on the basis of shortest path."),
                                  leading: Icon(Icons.directions_bike),
                                ),
                                ListTile(
                                  title:
                                  Text("To logout from the application."),
                                  leading: Icon(Icons.lock_outline),
                                ),
                                ListTile(
                                  title: Text(
                                      "Displays the number of dustbins which are filled >= 75%"),
                                  leading: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                      "Displays the number of dustbins which are filled >= 50% but < 75%"),
                                  leading: Icon(
                                    Icons.delete_sweep,
                                    color: Colors.yellow,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                      "Displays the number of dustbins which are filled < 50%"),
                                  leading: Icon(
                                    Icons.delete_outline,
                                    color: Colors.green,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                      "Displays the value in Liter of dustbins included in root."),
                                  leading: Icon(
                                    Icons.delete,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )).show();
                  },
                ),
              ],
            ),
          )), // new
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await myController.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    print(cl);
    print(jk);
    print(currentLocation);
    if (cl == true) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 20.0,
        ),
      ));
      pos1 = LatLng(currentLocation.latitude, currentLocation.longitude);
      print(pos1);
      cl = false;
    }
    if (jk == 0) {
      if (_isFavorited == true) {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(22.599588, 72.820503),
            zoom: 16.0,
          ),
        ));
      }
      if (_isFavorited == false) {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(22.597694985693487, 72.82150704413652),
            zoom: 19.0,
          ),
        ));
      }
      jk = 1;
    }
  }

  void CustomDialog(BuildContext context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 300.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                //color: Colors.grey[100],
                //borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //Text("Username: "'$username',style: TextStyle(fontSize: 10.0)),
                    SizedBox(
                      //width: 300.0,
                      //height: 450.0,
                      child: Card(
                          child: Text(
                            "Username: " '${username.toUpperCase()}',
                            style: TextStyle(fontSize: 25),
                          )),
                    ),
                    SizedBox(
                      //width: 300.0,
                      //height: 450.0,
                      child: Card(
                          child: Text("Mobile_no.: " '$mobile',
                              style: TextStyle(fontSize: 25))),
                    ),
                    SizedBox(
                      //width: 300.0,
                      //height: 450.0,
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.black),
                        ),
                      ), //Card(child: Text("Mobile_no.: " '$mobile', style: TextStyle(fontSize: 25))),
                    ),
                    //Text("Mobile_no.: "'$mobile',style: TextStyle(fontSize: 10.0)),
                  ],
                ),
                //child: Text("Username: "'$username',style: TextStyle(fontSize: 20.0,color: Colors.red),),
              ),
              /*child: Align(
              alignment: Alignment.center,
              child: Text(
                "Username : "'$username',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),*/
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '$level',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              // These values are based on trial & error method
              alignment: Alignment(1.0, -1.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
}

// ignore: non_constant_identifier_names

/*@override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
      _controller.complete(controller);
    },
    ),
    );
  }*/
/* @override

  GoogleMapController mapController;

  final LatLng _center = const LatLng(22.599588, 72.820503);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }*/
/*MapView mapView =MapView();
  CameraPosition cameraPosition;
  var staticMapProvider = StaticMapProvider("AIzaSyBBojDiyFeO2Sl-sCgC6X5Vcu5P7e8pkns");
  Uri staticMapUri;
  //GoogleMapController myController;
  @override
  void initState(){
    super.initState();
    cameraPosition = CameraPosition(Location(28.420035,77.337628),2.0);
    staticMapUri = staticMapProvider.getStaticUri(Location(28.420035,77.337628), 12,height: 400,width: 900,mapType: StaticMapViewType.roadmap);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 400.0,
         child: Stack(
           children: <Widget>[
             Center(
               child: Container(
                 child: Text("MAp",textAlign: TextAlign.center,),
                 padding: const EdgeInsets.all(20.0),
               ),
             ),
             InkWell(
               child: Center(
                 child: Image.network(staticMapUri.toString()),
               ),
               onTap: (){},
             ),
           ],
         ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Text("Tap the map",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Container(
            padding: EdgeInsets.only(top: 25.0),
            child: Text("Camera Position: \n\nLat: ${cameraPosition.center.latitude}"),
          )
        ],
        ),
      );
  }

}*/
//User1 use1;
//_AdminUserState(this.use1);
