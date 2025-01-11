import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         color: Colors.white,
         alignment: Alignment.center,
         child: SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text(Constants.appName,style: TextStyle(color: Colors.red,fontSize: 35,fontWeight: FontWeight.bold),),
               SizedBox(height: 100,),
               CircularProgressIndicator(color: Colors.red,),
             ],
           ),
         ),
       ),
    );
  }
}
