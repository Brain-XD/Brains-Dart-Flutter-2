import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MiPantalla(),
    );
  }
}




class MiPantalla extends StatefulWidget{
  @override
  _MiPantallaState createState() => _MiPantallaState();
}    

class _MiPantallaState extends State <MiPantalla>{         
  final _controlador = TextEditingController();

  @override
  void dispose(){
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('hola'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controlador,
            decoration: InputDecoration(
              labelText: 'ingrese su nombre',
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              final texto = _controlador.text;
              print('Nombre ingresado: $texto');
            },
            child: Text('Procesar'),
          ),
        ],
      ),
    );
  }
}