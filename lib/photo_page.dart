import 'dart:io'; // Para manipular arquivos
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Pacote para acessar a câmera e a galeria

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  File? _image; // Variável que armazenará a imagem selecionada ou capturada
  final ImagePicker _picker = ImagePicker(); // Inicializando o ImagePicker

  // Função para selecionar imagem da galeria
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Armazenando a imagem selecionada
      });
    }
  }

  // Função para capturar imagem com a câmera
  Future<void> _captureImageWithCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Armazenando a imagem capturada
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria/Câmera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Exibe a imagem selecionada ou capturada
            _image != null
                ? Image.file(
                    _image!,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  )
                : const Text('Nenhuma imagem selecionada.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: const Text('Selecionar da Galeria'),
            ),
            ElevatedButton(
              onPressed: _captureImageWithCamera,
              child: const Text('Capturar com a Câmera'),
            ),
          ],
        ),
      ),
    );
  }
}
