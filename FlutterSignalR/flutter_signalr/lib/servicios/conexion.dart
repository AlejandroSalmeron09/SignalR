import 'package:get/get.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService extends GetxService {
  late HubConnection hubConnection;
  final kChatServerUrl = "http://10.0.2.2:5253/contadorhub";

  var receivedNumber = 0.obs;
  var isConnected = false.obs; // Estado de conexión

  @override
  void onInit() {
    super.onInit();
    initSignalR();
  }

  void initSignalR() {
    hubConnection = HubConnectionBuilder().withUrl(kChatServerUrl).build();

    hubConnection.onclose(({error}) {
      isConnected.value = false;
      print('connection closed: $error');
    });

    hubConnection.on("ReciveNewNumber", (List<Object?>? args) {
      if (args != null && args.isNotEmpty) {
        receivedNumber.value = args[0] as int;
        Get.snackbar(
            'Nuevo mensaje', 'Número recibido: ${receivedNumber.value}');
      }
    });
  }

  Future<void> startConnection() async {
    if (hubConnection.state == HubConnectionState.Disconnected) {
      await hubConnection.start();
      isConnected.value = true;
    }
  }

  Future<void> stopConnection() async {
    if (hubConnection.state == HubConnectionState.Connected) {
      await hubConnection.stop();
      isConnected.value = false;
    }
  }

  Future<void> sendNumber(int number) async {
    if (hubConnection.state == HubConnectionState.Connected) {
      await hubConnection.invoke("ContadorViewFromServer", args: [number]);
    }
  }
}
