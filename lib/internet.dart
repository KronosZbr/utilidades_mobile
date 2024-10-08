import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetCheckPage extends StatefulWidget {
  @override
  _InternetCheckPageState createState() => _InternetCheckPageState();
}

class _InternetCheckPageState extends State<InternetCheckPage> {
  String _connectionStatus = 'Desconhecido';
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var result = await _connectivity.checkConnectivity();
    setState(() {
      if (result == ConnectivityResult.mobile) {
        _connectionStatus = 'Conectado via dados móveis';
      } else if (result == ConnectivityResult.wifi) {
        _connectionStatus = 'Conectado via Wi-Fi';
      } else {
        _connectionStatus = 'Sem conexão';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificar Internet'),
      ),
      body: Center(
        child: Text('Status da conexão: $_connectionStatus'),
      ),
    );
  }
}
