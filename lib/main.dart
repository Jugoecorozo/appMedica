import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/tipoDeCirugia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tema.dart';


final ThemeData miTemaClaro = ThemeData.from(colorScheme: lightColorScheme);
final ThemeData miTemaOscuro = ThemeData.from(colorScheme: darkColorScheme);

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=> datosFormulario() )],
      child: const MyApp()
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: miTemaClaro,
      darkTheme: miTemaOscuro,
      home: const SurgeryRiskCalculator(),
    );
  }
}
