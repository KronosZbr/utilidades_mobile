import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GpsPage extends StatefulWidget {
  @override
  _GpsPageState createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {
  String _locationMessage = "Localização desconhecida";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se os serviços de localização estão habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Serviços de localização estão desativados.";
      });
      return;
    }

    // Verifica se o usuário concedeu permissão de localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Permissão de localização negada.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Permissão de localização permanentemente negada.";
      });
      return;
    }

    // Obtém a localização atual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acessar GPS"),
      ),
      body: Center(
        child: Text(_locationMessage),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        tooltip: 'Obter localização',
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
