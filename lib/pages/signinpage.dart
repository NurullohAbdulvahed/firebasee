import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepost/pages/signuppage.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/pref_service.dart';
import '../services/utils.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  static String id = "SignInPage";
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


  void doLogin(){
    String email = emailcontroller.text.toString().trim();
    String password = emailcontroller.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return ;
    setState(() {
      isLoading = true;
    });
    AuthService.signInUser(context, email, password).then((firebaseUser) => {
      print("KELMADI!!!!!!!!!!!!"),
      _getFirebaseUser(firebaseUser!),
    });


  }
  void _getFirebaseUser(User firebaseUser)async{
    setState(() {
      isLoading = false;
    });
    if(firebaseUser != null){
      print("njjdsjabdsa");
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
    else{
       Utils.fireToast("Check all information");
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
                onPressed: doLogin,
                child: Text("Sign In",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Don`t have an account?"),
                SizedBox(width: 10,),
                MaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(context, SignUpPage.id);
                    },
                    child: Text("Sign Up")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
