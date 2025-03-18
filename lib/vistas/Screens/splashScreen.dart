
import 'package:flutter/material.dart';
import 'package:app_medica/vistas/Screens/datosPersonales.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.png'),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => datosPersonales()),
                );
              },
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}