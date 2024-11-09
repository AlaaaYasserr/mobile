import 'package:app/MyAppbar.dart';
import 'package:app/Prayer.dart';
import 'package:app/Weather.dart';
import 'package:app/WeatherService.dart';
import 'package:app/prayerTimesService.dart';
import 'package:flutter/material.dart';


class get_data extends StatefulWidget{

  bool weather_praytime=false;

  get_data(bool weather_praytime){
    
    this.weather_praytime=weather_praytime;

  }

  @override
  State<StatefulWidget> createState() {

    return _get_data(this.weather_praytime);
  }

  
}

class _get_data extends State<get_data>{

  bool weather_praytime=false;
  late String message;

    @override
  void initState() {

    message='';
  }

  _get_data(bool weather_praytime){
    
    this.weather_praytime=weather_praytime;

  }

  final List<List<String>> cities= [
    ['New York', 'United States'],
    ['Paris', 'France'],
    ['Tokyo', 'Japan'],
    ['Dubai', 'United Arab Emirates'],
    ['London', 'United Kingdom'],
    ['Sydney', 'Australia'],
    ['Toronto', 'Canada'],
    ['Rome', 'Italy'],
    ['Istanbul', 'Turkey'],
    ['Bangkok', 'Thailand'],
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 201, 150, 146),

      appBar: MyAppbar.myappbar(context),
      body: SingleChildScrollView(

        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Container(
              height: 250,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [Colors.teal.shade200, Colors.teal.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ListWheelScrollView.useDelegate(
                itemExtent: 50,
                diameterRatio: 1.5,
                perspective: 0.003,
                physics: FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) async {

                  if(this.weather_praytime){
                    
                    try{

                      WeatherService weatherService=WeatherService();
                      Weather weather=await weatherService.fetchWeather(cities[index][0]);

                      setState(() {
                        message='city: '+ weather.cityName+"\n"+ weather.temperature.toString()+" celsius\n"+weather.description;
                      });

                    }catch(e){ setState(() {
                      message='there is a problem';
                    });}
                  }

                  else{
                  
                    try{

                    PrayerTimesService prayerTimesService = PrayerTimesService();
                    PrayerTimes prayerTimes = await prayerTimesService.fetchPrayerTimes(cities[index][0],cities[index][1]);

                    setState(() {
                      message="city: "+cities[index][0]+
                      "\nfajir: "+prayerTimes.fajr+" duhur: "+prayerTimes.dhuhr+" aser: "+prayerTimes.asr+"\n"+
                      " majerb: "+prayerTimes.maghrib+" aisha: "+prayerTimes.isha;
                    });

                    }catch(e){
                      setState(() {
                        message='there is a problem';
                      });
                    }

                  }

                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        cities[index][0],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  childCount: cities.length,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(message,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
          ],
        ),
      ),
    
        
      ),
    );
  }


  
}