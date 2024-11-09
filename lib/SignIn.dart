import 'package:app/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:app/MyTextfiled.dart';
import 'package:app/Mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _signIn();
  }
  
}

class _signIn extends State<SignIn>{

  late String message;
  @override
  void initState() {
    message='';
    super.initState();
  }

  MyTextField email=MyTextField('Email', 'alaa@gmail.com', Icon(Icons.email)),
  password=MyTextField('password', 'qazWSX1@', Icon(Icons.password),dont_show_text: true,);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text('Sign In'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.redAccent,fontSize: 25,fontWeight: FontWeight.bold),
      ),
      body:

      SingleChildScrollView(
      
        child:   Container(

            padding: EdgeInsets.all(25),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

              email,
              SizedBox(height: 20,),
              password,
              SizedBox(height: 20,),
              Mybutton('Sign In', Icon(Icons.login), () async {

                try {

                  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email.getController(),
                    password:password.getController()
                  );
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false); 

                } on FirebaseAuthException catch (e) {

                  setState(() {
                    message='cant sign in';
                  });
                }
               }),
              SizedBox(height: 20,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()),);
                }, child: Text('create account')),
              SizedBox(height: 20,),
              Center(child: Text(message),)

              ],
            ),
          ),
      )
    );
  }
  
}