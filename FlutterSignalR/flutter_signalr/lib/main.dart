import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final kChatServerUrl = "http://10.0.2.2:5253/contadorhub";
  late HubConnection hubConnection;

  @override
  void initState() {
    super.initState();
    initSignalR();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    _sendCounterToServer();
  }

  Future<void> _sendCounterToServer() async {
    if (hubConnection.state == HubConnectionState.Connected) {
      try {
        await hubConnection.invoke("ContadorViewFromServer", args: [_counter]);
      } catch (error) {
        print("Error invoking method: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Este es el contador',
            ),
            FloatingActionButton(
              onPressed: () async {
                hubConnection.state == HubConnectionState.Disconnected
                    ? await hubConnection.start()
                    : await hubConnection.stop();
              },
              tooltip: 'Start/Stop',
              child: hubConnection.state == HubConnectionState.Disconnected
                  ? Icon(Icons.play_arrow)
                  : Icon(Icons.stop),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void initSignalR() {
    hubConnection = HubConnectionBuilder().withUrl(kChatServerUrl).build();

    hubConnection.onclose(({error}) => print('connection closed: $error'));

    // Actualización aquí: usa List<Object?>? en lugar de int
    hubConnection.on("ReciveNewNumber", (List<Object?>? args) {
      if (args != null && args.isNotEmpty) {
        _handleNewNumber(args[0] as int);
      }
    });
  }

  // Asegúrate de que el tipo de _handleNewNumber coincida con lo que esperas recibir
  void _handleNewNumber(int n) {
    setState(() {
      _counter = n;
    });
  }
}
