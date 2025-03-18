import 'package:flutter/material.dart';

class EscalaLangeron extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaLangeron({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaLangeronState createState() => _EscalaLangeronState();
}

class _EscalaLangeronState extends State<EscalaLangeron> {
  // Valores iniciales según la escala de Langeron
  int obesidad = 0;
  int barba = 0;
  int edentacion = 0;
  int apnea = 0;
  int edad = 0;

  // Función para actualizar el resultado de la escala
  void _updateValue() {
    final int total = obesidad + barba + edentacion + apnea + edad;
    final String result =
        '$total puntos, ${total >= 2 ? 'probable ventilación difícil con máscara facial' : 'ventilación fácil con máscara facial'}';
    widget.updateScaleValue('Escala de Langeron', result); // Enviar resultado al padre
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escala de Langeron',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        
        // Obesidad
        _buildDropdown('Obesidad (IMC > 26 kg/m2)', obesidad, {
          'No (0 puntos)': 0,
          'Sí (1 punto)': 1,
        }, (value) {
          setState(() {
            obesidad = value!;
            _updateValue(); // Actualizar la suma
          });
        }),
        
        // Barba
        _buildDropdown('Barba', barba, {
          'No (0 puntos)': 0,
          'Sí (1 punto)': 1,
        }, (value) {
          setState(() {
            barba = value!;
            _updateValue(); // Actualizar la suma
          });
        }),

        // Edentación
        _buildDropdown('Edentación', edentacion, {
          'No (0 puntos)': 0,
          'Sí (1 punto)': 1,
        }, (value) {
          setState(() {
            edentacion = value!;
            _updateValue(); // Actualizar la suma
          });
        }),

        // Apnea
        _buildDropdown('Síndrome de apnea obstructiva del sueño', apnea, {
          'No (0 puntos)': 0,
          'Sí (1 punto)': 1,
        }, (value) {
          setState(() {
            apnea = value!;
            _updateValue(); // Actualizar la suma
          });
        }),

        // Edad
        _buildDropdown('Edad > 55 años', edad, {
          'No (0 puntos)': 0,
          'Sí (1 punto)': 1,
        }, (value) {
          setState(() {
            edad = value!;
            _updateValue(); // Actualizar la suma
          });
        }),
      ],
    );
  }

  // Método para construir el DropdownButton
  Widget _buildDropdown(String label, int currentValue, Map<String, int?> options, ValueChanged<int?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        DropdownButton<int?>(
          value: currentValue,
          items: options.entries.map((entry) {
            return DropdownMenuItem<int?>(
              value: entry.value,
              child: Text(entry.key),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              onChanged(value); // Actualiza el valor seleccionado
            });
          },
        ),
      ],
    );
  }
}