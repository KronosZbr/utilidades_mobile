import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeAccelerometerPage extends StatefulWidget {
  @override
  _GyroscopeAccelerometerPageState createState() =>
      _GyroscopeAccelerometerPageState();
}

class _GyroscopeAccelerometerPageState
    extends State<GyroscopeAccelerometerPage> {
  double _xGyroscope = 0.0;
  double _yGyroscope = 0.0;
  double _zGyroscope = 0.0;

  double _xAccelerometer = 0.0;
  double _yAccelerometer = 0.0;
  double _zAccelerometer = 0.0;

  @override
  void initState() {
    super.initState();

    // Listening to gyroscope events
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _xGyroscope = event.x;
        _yGyroscope = event.y;
        _zGyroscope = event.z;
      });
    });

    // Listening to accelerometer events
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _xAccelerometer = event.x;
        _yAccelerometer = event.y;
        _zAccelerometer = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscópio e Acelerômetro'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[200], // Cor de fundo
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSensorCard(
                'Giroscópio', _xGyroscope, _yGyroscope, _zGyroscope),
            _buildSensorCard('Acelerômetro', _xAccelerometer, _yAccelerometer,
                _zAccelerometer),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard(String title, double x, double y, double z) {
    return Card(
      elevation: 4,
      child: Container(
        width: 150, // Largura do card
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('X: ${x.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16)),
            Text('Y: ${y.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16)),
            Text('Z: ${z.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
