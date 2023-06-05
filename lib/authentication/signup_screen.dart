import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import 'package:users_app/widgets/progress_dialogue.dart';

import '../global/global.dart';

class SignUpScreen extends StatefulWidget
{
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
{

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

validateForm()
{
  if(nameTextEditingController.text.length < 3)
    {
      Fluttertoast.showToast(msg: "name must be at least 3 characters.");
    }
  else if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "invalid email");
    }
  else if (phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone number is required");
    }
  else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "password must be at least 6 characters");
    }
  else
    {
      saveUsererInfoNow();
    }
}

saveUsererInfoNow() async
{
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext c)
    {
      return ProgressDialogue(message: "Processing...please wait",);
    },
  );

  final User? firebaseUser = (
      await fAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
      ).catchError((msg) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error: " + msg.toString());
      })
  ).user;

  if(firebaseUser != null)
    {
      Map userMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController. text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("users");
      driversRef.child(firebaseUser.uid).set(userMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created successfully.");
      Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
    }
  else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created.");
    }

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              const SizedBox(height: 10,),

              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("images/logo.png"),
              ),

              const SizedBox(height: 10,),

              const Text(
                "Register as User",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your full name",

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                    ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email here",

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Enter Phone Number",

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter password",

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                  onPressed: ()
                  {
                    validateForm();
                    // Navigator.push(context, MaterialPageRoute(builder: (c)=> const CarInfoScreen()));
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                ),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
              ),

              TextButton(
                child: const Text(
                  "Already have an account? Login here",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
