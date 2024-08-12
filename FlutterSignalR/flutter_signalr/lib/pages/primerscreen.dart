import 'package:flutter/material.dart';
import 'package:flutter_signalr/servicios/conexion.dart';
import 'package:get/get.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signalRService = Get.find<SignalRService>();

    return Scaffold(
      appBar: AppBar(title: Text("Pantalla 1")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(
                'Número recibido: ${signalRService.receivedNumber}',
                style: TextStyle(fontSize: 24),
              )),
              SizedBox(height: 20),
              Obx(() => FloatingActionButton(
                onPressed: () {
                  signalRService.isConnected.value
                      ? signalRService.stopConnection()
                      : signalRService.startConnection();
                },
                tooltip: signalRService.isConnected.value ? 'Desconectar' : 'Conectar',
                child: Icon(signalRService.isConnected.value ? Icons.stop : Icons.play_arrow),
              )),
              SizedBox(height: 20),
              FloatingActionButton(
                onPressed: () {
                  signalRService.sendNumber(1);
                },
                tooltip: 'Enviar 1',
                child: Icon(Icons.send),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.toNamed('/second'),
                child: Text("Ir a Pantalla 2"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
