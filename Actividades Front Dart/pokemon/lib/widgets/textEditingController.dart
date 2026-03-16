import 'package:flutter/material.dart';

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