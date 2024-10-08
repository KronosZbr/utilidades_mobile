import 'package:flutter/material.dart';
import 'internet.dart'; // Importando a página de verificação de internet
import 'gps_page.dart'; // Importando a página de GPS
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget splashScreen = SplashScreenView(
      navigateRoute: const HomeScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc:
          "assets/download.jpeg", // Certifique-se que essa imagem está no local correto
      text: "Bem-Vindo ao Meu App",
      textStyle: const TextStyle(fontSize: 30.0),
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      home: splashScreen,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.wifi),
              title: const Text('Verificar Wi-Fi'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        InternetCheckPage(), // Abre a tela de verificação de Internet
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Acessar GPS'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GpsPage(), // Abre a tela de GPS
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Acessar Galeria/Câmera'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videogame_asset),
              title: const Text('Jogos da Velha com IA'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.device_unknown),
              title: const Text('Giroscópio e Acelerômetro'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Enviar Mensagem para WhatsApp'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Bem-vindo à Home Page!'),
      ),
    );
  }
}
