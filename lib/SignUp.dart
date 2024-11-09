import 'package:flutter/material.dart';
import 'package:app/MyTextfiled.dart';
import 'package:app/Mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _signUp();
  }
  
}

class _signUp extends State<SignUp>{

  late String message;
  @override
  void initState() {
    message='';
    super.initState();
  }


  MyTextField email=MyTextField('Email', 'alaa@gmail.com', Icon(Icons.email)),
  password=MyTextField('password', 'qazWSX1@', Icon(Icons.password),dont_show_text: true,),
  confirm_password=MyTextField('confirm password', 'qazWSX1@', Icon(Icons.password),dont_show_text: true,);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text('Sign Up'),
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
              confirm_password,
              SizedBox(height: 20,),
              Mybutton('Sign Up', Icon(Icons.login), () async {

                if(confirm_password.getController()==password.getController()){

                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.getController(),
                        password: password.getController(),
                      );
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false); 
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        setState(() {
                          message='The password provided is too weak.';
                        });
                      } else if (e.code == 'email-already-in-use') {
                        
                        setState(() {
                          message='The email is used';
                        });
                      }
                    } catch (e) {
                      print(e);
                    }

                }
                else{
                  setState(() {
                    message='confirm the password correctly';
                  });
                }
              }),
              SizedBox(height: 20,),
              Center(child: Text(message),)

              ],
            ),
          ),
      )
    );
  }
  
}