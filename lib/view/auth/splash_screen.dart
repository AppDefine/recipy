import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipy/view/auth/login_screen.dart';
import 'package:recipy/view/dashboard_screen.dart';

import '../../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2),() {
      navigationFun();
    },);
    super.initState();
  }

  Future<void> navigationFun() async {
    final pref = Constants.securePreferences();
    var isLogin  = await pref.read(key: Constants.isLogin);
    if(isLogin==true.toString()){
      Get.offAll(()=>DashboardScreen());
    }else{
      Get.offAll(()=>LoginScreen());
    }
  }

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
