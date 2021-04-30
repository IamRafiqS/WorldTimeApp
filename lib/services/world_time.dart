import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location for the UI
  String time; //time in the location
  String flag; //url to assets flag icons
  String url; //url for location endpoint
  bool isDaytime = true; //true if daytime and vice versa
  //initial url value = '/api/timezone/Asia/Kuala_Lumpur'

  WorldTime({this.location, this.flag, this.url});

  Future <void> getTime() async {
    try {
      //get request
      Response response = await get(Uri.https('worldtimeapi.org', '$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //Convert string into datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //check if it is day or night
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;

      //convert datetime format into better format
      time = DateFormat.jm().format(now);
    }

    catch(e){
      print('error caught by: $e');
      time = 'error time not available';
    }
  }

}

