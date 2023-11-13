import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_hotel/home/home.dart';
import 'package:lottie/lottie.dart';

class Splach extends StatefulWidget {
  const Splach({Key? key}) : super(key: key);

  @override
  State<Splach> createState() => _SplachState();
}

class _SplachState extends State<Splach> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'MyHomePage')),
      );

    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:     Lottie.asset(
          'assets/ai.json'),
      ),
    );
  }
}
