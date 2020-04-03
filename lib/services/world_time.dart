import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for UI
  String time;// time at location
  String dmy; // date at location
  String flag; // url to an asset flag icon
  String url; // location url for api end point
  bool isDaytime; //true or false if day or night

  WorldTime({this.location, this.url, this.flag});

  Future<void> getTime() async {

    try {
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offseth = data['utc_offset'].substring(0,3);
      String offsetm = data['utc_offset'].substring(0,1) + data['utc_offset'].substring(4);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offseth), minutes: int.parse(offsetm)));

      //set time property
      isDaytime =  now.hour>6 && now.hour<20   ? true: false;
      time = DateFormat.jm().format(now);
      print(time);
      dmy= DateFormat.yMMMMEEEEd().format(now);
      print(dmy);

    }

    catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }

}


