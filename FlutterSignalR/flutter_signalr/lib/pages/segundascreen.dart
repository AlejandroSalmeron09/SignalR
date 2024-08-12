import 'package:flutter/material.dart';
import 'package:flutter_signalr/servicios/conexion.dart';
import 'package:get/get.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signalRService = Get.find<SignalRService>();

    return Scaffold(
      appBar: AppBar(title: Text("Pantalla 2")),
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
                  signalRService.sendNumber(2);
                },
                tooltip: 'Enviar 2',
                child: Icon(Icons.send),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text("Volver a Pantalla 1"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
