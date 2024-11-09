import 'package:app/MyAppbar.dart';
import 'package:app/Mybutton.dart';
import 'package:app/get_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Home extends StatelessWidget{

  


  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.sizeOf(context).width*0.9; 

    return Scaffold(

      backgroundColor: Color.fromARGB(255, 255, 0, 174),

      appBar: MyAppbar.myappbar(context),
      body: SingleChildScrollView(
        
        child: Container(
          padding: EdgeInsets.all(15),
          child: Center( child:  Column(


            children: <SizedBox>[

              SizedBox(height: 20,),

              SizedBox( child:  Mybutton('weather',Icon(Icons.wb_sunny, color: Colors.orange, size: 30.0), () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => get_data(true)),);
               }),
              width: width),

              SizedBox(height: 40,),
               
              SizedBox( child:  Mybutton('prayer time',Icon(FontAwesomeIcons.mosque, color: Colors.green, size: 30.0), () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => get_data(false)),);
               }),
              width: width,)


            ],
          ),
          
        )),
      ),
    );
  }

  
}

