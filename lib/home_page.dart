import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  var currentLocation;
  var coordinates;

  @override
  void initState() {
    // TODO: implement initState

    _getLocation();
    super.initState();
  }

  Future<void> _launchURL() async {
    final url = 'https://www.google.com/maps/dir///@$coordinates,15z';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _getLocation() async {
    var currentLocation;

    try {
      currentLocation = await Location().getLocation();
      coordinates =
          "${currentLocation.latitude.toString()} , ${currentLocation.longitude.toString()}";
      print(currentLocation.latitude);
      print(currentLocation.longitude);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {}
      currentLocation = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Auth>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(model.userEmail),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              model.logout();
            },
            icon: Icon(Icons.all_out),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.send),
          onPressed: () => _launchURL()),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {},
                    child: Text("click"),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("click"),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {},
                    child: Text("click"),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("click"),
                  )
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {},
                    child: Text("click"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
