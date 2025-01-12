import 'dart:convert';
import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/Screens/datosPersonales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:json_theme_plus/json_theme_plus.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeStr2 = await rootBundle.loadString('assets/appainter_theme2.json');

  final themeJson = jsonDecode(themeStr);
  final themeJson2 = jsonDecode(themeStr2);
  
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  final theme2 = ThemeDecoder.decodeThemeData(themeJson2)!;

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=> datosFormulario() )],
      child: MyApp(theme: theme, darkTheme: theme2,)
      )
    );
}

class MyApp extends StatelessWidget {
  final ThemeData theme, darkTheme;
  
  const MyApp({super.key, required this.theme, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      home: datosPersonales()    
      );
  }
}
