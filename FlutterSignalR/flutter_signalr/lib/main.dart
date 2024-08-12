import 'package:flutter/material.dart';
import 'package:flutter_signalr/pages/primerscreen.dart';
import 'package:flutter_signalr/pages/segundascreen.dart';
import 'package:flutter_signalr/servicios/conexion.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter SignalR Demo',
      initialBinding: BindingsBuilder(() {
        Get.put(SignalRService());
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(),
      getPages: [
        GetPage(name: '/', page: () => FirstScreen()),
        GetPage(name: '/second', page: () => SecondScreen()),
      ],
    );
  }
}
