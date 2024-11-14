import 'package:flutter/material.dart';

class Apfel extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Apfel({super.key, required this.onValueUpdated});

  @override
  State<Apfel> createState() => _ApfelState();
}

class _ApfelState extends State<Apfel> {
  bool isFemale = false;
  bool isSmoker = false;
  bool hasNauseaAndVomiting = false;
  bool hasPostoperativeOpioids = false;

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Escala De APFEL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            title: const Text('¿Es usted de sexo femenino?'),
            value: isFemale,
            onChanged: (newValue) {
              setState(() {
                isFemale = newValue ?? false;
                _calculateResult
                ();
              });
            },
          ),
          CheckboxListTile(
            title: const Text('¿Es usted fumador?'),
            value: isSmoker,
            onChanged: (newValue) {
              setState(() {
                isSmoker = newValue ?? false;
                _calculateResult();
              });
            },
          ),
          CheckboxListTile(
            title: const Text('¿Tiene historia de náuseas y vómito postoperatorio o cinetosis?'),
            value: hasNauseaAndVomiting,
            onChanged: (newValue) {
              setState(() {
                hasNauseaAndVomiting = newValue ?? false;
                _calculateResult();
              });
            },
          ),
          CheckboxListTile(
            title: const Text('¿Ha usado opioides en el postoperatorio?'),
            value: hasPostoperativeOpioids,
            onChanged: (newValue) {
              setState(() {
                hasPostoperativeOpioids = newValue ?? false;
                _calculateResult();
              });
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _calculateResult() {
    int points = 0;
    String risk = '';

    if (isFemale) points ++;
    if (isSmoker) points ++;
    if (hasNauseaAndVomiting) points ++;
    if (hasPostoperativeOpioids) points ++;

    if (points == 0) {
      risk = 'Muy bajo (10%)';
    } else if (points == 1) {
      risk = 'Bajo (20%)';
    } else if (points == 2) {
      risk = 'Moderado (40%)';
    } else if (points == 3) {
      risk = 'Alto (60%)';
    } else {
      risk = 'Muy Alto (80%)';
    }

    widget.onValueUpdated('ESCALA DE APFEL',' $points puntos, riesgo: $risk para presentar NVPO.');
  }
}