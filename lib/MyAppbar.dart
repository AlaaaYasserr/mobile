import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAppbar{

  static AppBar myappbar(BuildContext context){

    return AppBar(
        backgroundColor: const Color.fromARGB(255, 168, 185, 198),
        actions: <PopupMenuButton>[PopupMenuButton<bool>(
          
          onSelected: (value) async {
            if(value==true){
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/sign_in', (route) => false); 
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem( value: true,child: Text('Sign out'),),
              
              
              ]; }, icon: Icon(Icons.menu), 
          )
          ],
      );
  }
}

