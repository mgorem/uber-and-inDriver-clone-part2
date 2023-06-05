import "dart:async";

import "package:flutter/material.dart";
import "package:users_app/authentication/login_screen.dart";
import "package:users_app/mainScreens/main_screen.dart";

import "../global/global.dart";

    class MySplashScreen extends StatefulWidget {
      const MySplashScreen({Key? key}) : super(key: key);

      @override
      State<MySplashScreen> createState() => _MySplashScreenState();
    }

    class _MySplashScreenState extends State<MySplashScreen>
    {

      startTimer()
      {
        Timer(const Duration(seconds: 3), () async
        {
           if(await fAuth.currentUser != null)
             {
               currentFirebaseUser = fAuth.currentUser;
               // send user to main screen
               Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
             }
           else
             {
                // send user to login screen
                Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
             }
        });
      }

      @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
  }

      @override
      Widget build(BuildContext context) {
        return Material(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset("images/logo.png"),

                  SizedBox(height: 10,),

                  const Text(
                    "Uber and inDriver Clone App",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            )
            
          ),
        );
      }
    }
