import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappMessagePage extends StatelessWidget {
  const WhatsappMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar Mensagem para WhatsApp'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendMessage,
          child: const Text('Enviar Mensagem'),
        ),
      ),
    );
  }

  void _sendMessage() async {
    final String message = "Olá, esta é uma mensagem do meu app!";
    final String phoneNumber = "+5544998788326";
    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    if (await canLaunch(whatsappUrl.toString())) {
      await launch(whatsappUrl.toString());
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }
}
