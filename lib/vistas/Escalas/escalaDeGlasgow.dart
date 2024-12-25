import 'package:flutter/material.dart';

class EscalaGlasgow extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaGlasgow({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaGlasgowState createState() => _EscalaGlasgowState();
}

class _EscalaGlasgowState extends State<EscalaGlasgow> {
  int? respuestaOcular; // Valor inicial nulo para el placeholder
  int? respuestaVerbal; // Valor inicial nulo para el placeholder
  int? respuestaMotora; // Valor inicial nulo para el placeholder

  // Función para actualizar el resultado de la escala
  void _updateValue() {
    final int total = (respuestaOcular ?? 0) + (respuestaVerbal ?? 0) + (respuestaMotora ?? 0);
    final String result =
        'Escala de Glasgow: $total Puntos (Respuesta ocular: ${respuestaOcular ?? 0} puntos, Respuesta verbal: ${respuestaVerbal ?? 0} puntos, Respuesta motora: ${respuestaMotora ?? 0} puntos)';
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
          'Elige una opción': null,
          'Espontánea (4 puntos)': 4,
          'A estímulos verbales (3 puntos)': 3,
          'Al dolor (2 puntos)': 2,
          'Ausencia de respuesta (1 punto)': 1,
        }, (value) {
          setState(() {
            respuestaOcular = value!;
            _updateValue(); // Actualizar la suma
          });
        }),

        // Respuesta verbal
        _buildDropdown('Respuesta verbal', respuestaVerbal, {
          'Elige una opción': null,
          'Orientado (5 puntos)': 5,
          'Desorientado/confuso (4 puntos)': 4,
          'Incoherente (3 puntos)': 3,
          'Sonidos incomprensibles (2 puntos)': 2,
          'Ausencia de respuesta (1 punto)': 1,
        }, (value) {
          setState(() {
            respuestaVerbal = value!;
            _updateValue(); // Actualizar la suma
          });
        }),

        // Respuesta motora
        _buildDropdown('Respuesta motora', respuestaMotora, {
          'Elige una opción': null,
          'Obedece órdenes (6 puntos)': 6,
          'Localiza el dolor (5 puntos)': 5,
          'Retirada al dolor (4 puntos)': 4,
          'Flexión anormal (3 puntos)': 3,
          'Extensión anormal (2 puntos)': 2,
          'Ausencia de respuesta (1 punto)': 1,
        }, (value) {
          setState(() {
            respuestaMotora = value!;
            _updateValue(); // Actualizar la suma
          });
        }),
      ],
    );
  }

  // Método para construir el DropdownButton
  Widget _buildDropdown(String label, int? currentValue, Map<String, int?> options, ValueChanged<int?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        DropdownButton<int?>(
          value: currentValue == 0 ? null : currentValue,
          hint: const Text("Selecciona una opción"), // Placeholder inicial
          items: options.entries.map((entry) {
            return DropdownMenuItem<int?>(
              value: entry.value,
              child: Text(entry.key),
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
