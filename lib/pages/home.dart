import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    //set background image
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo;
    Color txtColor = data['isDaytime'] ? Colors.black : Colors.black54;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: [
                TextButton.icon(
                    onPressed: () async {
                       dynamic result = await Navigator.pushNamed(context, '/location');
                       setState(() {
                         data = {
                           'location': result['location'],
                           'time' : result['time'],
                           'flag' : result['flag'],
                           'isDaytime': result['isDaytime'],
                         };
                       });
                    },
                    icon: Icon(Icons.map_rounded,
                    color: Colors.black,
                    ),
                    label: Text('Edit Location',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    )
                ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['location'],
                      style: TextStyle(
                        fontSize: 28.00,
                        letterSpacing: 2.0,
                        color: txtColor
                      ) ),

                    ],
                  ),
                  SizedBox(height: 20),
                  Text(data['time'],
                    style: TextStyle(
                      fontSize: 66,
                      color: txtColor
                  ),)

        ]
              ),
            ),
          )
      ),
    );
  }
}
