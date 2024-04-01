import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=> datosFormulario() )],
      child: MyApp()
      )
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Text(
          '¡Hola, mundo!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
