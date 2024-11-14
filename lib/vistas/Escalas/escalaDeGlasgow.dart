import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class EscalaGlasgow extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaGlasgow({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaGlasgowState createState() => _EscalaGlasgowState();
}

class _EscalaGlasgowState extends State<EscalaGlasgow> {
  // Valores iniciales según la escala de Glasgow
  int respuestaOcular = 4;  // Valor inicial de respuesta ocular
  int respuestaVerbal = 5;  // Valor inicial de respuesta verbal
  int respuestaMotora = 6;  // Valor inicial de respuesta motora

  // Función para actualizar el resultado de la escala
  void _updateValue() {
    final int total = respuestaOcular + respuestaVerbal + respuestaMotora;
    final String result =
        'Escala de Glasgow: $total Puntos (Respuesta ocular: $respuestaOcular puntos, Respuesta verbal: $respuestaVerbal puntos, Respuesta motora: $respuestaMotora puntos)';
    widget.updateScaleValue('Escala de Glasgow', result); // Enviar resultado al padre
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escala de Glasgow',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        
        // Respuesta ocular
        _buildDropdown('Respuesta ocular', respuestaOcular, {
          'Espontánea (4 puntos)': 4,
          'A estímulos verbales (3 puntos)': 3,
          'Al dolor (2 puntos)': 2,
          'Ausencia de respuesta (1 punto)': 1,
        }, (value) {
          setState(() {
            respuestaOcular = value;
            _updateValue(); // Actualizar la suma
          });
        }),
        
        // Respuesta verbal
        _buildDropdown('Respuesta verbal', respuestaVerbal, {
          'Orientado (5 puntos)': 5,
          'Desorientado/confuso (4 puntos)': 4,
          'Incoherente (3 puntos)': 3,
          'Sonidos incomprensibles (2 puntos)': 2,
          'Ausencia de respuesta (1 punto)': 1,
        }, (value) {
          setState(() {
            respuestaVerbal = value;
            _updateValue(); // Actualizar la suma
          });
        }),

        // Respuesta motora
        _buildDropdown('Respuesta motora', respuestaMotora, {
          'Obedece órdenes (6 puntos)': 6,
          'Localiza el dolor (5 puntos)': 5,
          'Retirada al dolor (4 puntos)': 4,
          'Flexión anormal (3 puntos)': 3,
          'Extensión anormal (2 puntos)': 2,
          'Ausencia de respuesta (1 punto)': 1,
        }, (value) {
          setState(() {
            respuestaMotora = value;
            _updateValue(); // Actualizar la suma
          });
        }),
      ],
    );
  }

  // Método para construir el DropdownButton
  Widget _buildDropdown(String label, int currentValue, Map<String, int> options, ValueChanged<int> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: currentValue,
          items: options.entries.map((entry) {
            return DropdownMenuItem<int>(
              value: entry.value,
              child: Text('${entry.key}'),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value); // Actualiza el valor seleccionado
            }
          },
        ),
      ],
    );
  }
}
