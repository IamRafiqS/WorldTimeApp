import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List locations = [
    WorldTime(location: 'London', flag: 'uk.png', url: '/api/timezone/Europe/London'),
    WorldTime(location: 'Paris', flag: 'france.png', url: '/api/timezone/Europe/Paris'),
    WorldTime(location: 'Nairobi', flag: 'kenya.png', url: '/api/timezone/Africa/Nairobi'),
    WorldTime(location: 'Johannesburg', flag: 'safrica.png', url: '/api/timezone/Africa/Johannesburg'),
    WorldTime(location: 'Kuala Lumpur', flag: 'my.png', url: '/api/timezone/Asia/Kuala_Lumpur'),
    WorldTime(location: 'Tokyo', flag: 'japan.png', url: '/api/timezone/Asia/Tokyo'),
    WorldTime(location: 'Los Angeles', flag: 'us.png', url: '/api/timezone/America/Los_Angeles'),
    WorldTime(location: 'Toronto', flag: 'canada.png', url: '/api/timezone/America/Toronto'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();

    //go to home screen
    Navigator.pop(context, {
      'location' : instance.location,
      'flag' : instance.flag,
      'time' : instance.time,
      'isDaytime' : instance.isDaytime
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose your Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                      updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
