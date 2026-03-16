import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tarjeta Interactiva'),
        ),
        body: Center(
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Esquinas más redondeadas
            ),
            child: InkWell(
              onTap: () {
                // lógica que se ejecuta al hacer clic
                print('¡La tarjeta ha sido tocada!');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Tocaste la tarjeta!')),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: ListTile(
                  leading: Icon(Icons.person, size: 40, color: Colors.blue),
                  title: Text('Perfil de Usuario', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Toca para ver más información.'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
