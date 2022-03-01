import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepost/pages/signinpage.dart';
import 'package:firepost/services/auth_service.dart';
import 'package:firepost/services/utils.dart';
import 'package:flutter/material.dart';

import '../services/pref_service.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  static String id = "SignUpPage";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


 void doSignUp(){
   String email = emailcontroller.text.toString().trim();
   String name = emailcontroller.text.toString().trim();
   String password = emailcontroller.text.toString().trim();
   AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
     _getFirebaseUser(firebaseUser!),
   });

 }
 void _getFirebaseUser(User firebaseUser)async{
   if(firebaseUser != null){
     await Prefs.saveUserId(firebaseUser.uid);
     Navigator.pushReplacementNamed(context, HomePage.id);
   }
   else{
     Utils.fireToast("Tugadi");
   }
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                  hintText: "Fullname"
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  hintText: "Email"
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                  hintText: "Password"
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 45,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: doSignUp,
                child: Text("Sign Up",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Already have you  an account?"),
                SizedBox(width: 10,),
                MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, SignInPage.id);
                },
                child: Text("Sign In"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
