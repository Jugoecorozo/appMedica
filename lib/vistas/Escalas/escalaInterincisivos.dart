import 'package:flutter/material.dart';

class EscalaInterincisivos extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaInterincisivos({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaInterincisivosState createState() => _EscalaInterincisivosState();
}

class _EscalaInterincisivosState extends State<EscalaInterincisivos> {
  int? clase;

  void _updateValue() {
    String descripcion;
    switch (clase) {
      case 1:
        descripcion = 'Distancia interincisivos >3 cm, sin dificultad en la laringoscopia';
        break;
      case 2:
        descripcion = 'Distancia interincisivos entre 2.6-3 cm, dificultad leve en la laringoscopia';
        break;
      case 3:
        descripcion = 'Distancia interincisivos entre 2-2.5 cm, dificultad moderada en la laringoscopia';
        break;
      case 4:
        descripcion = 'Distancia interincisivos <2 cm, dificultad en la laringoscopia';
        break;
      default:
        descripcion = '';
    }
    String result = 'Distancia Interincisivos: $descripcion';
    widget.updateScaleValue('Distancia Interincisivos', result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Distancia Interincisivos (Apertura Oral)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        _buildDropdown('Clase', [
          'Clase I, Distancia de más de 3 cm',
          'Clase II, Distancia de 2.6-3 cm',
          'Clase III, Distancia de 2-2.5 cm',
          'Clase IV, Distancia de menos de 2 cm',
        ], (value) {
          setState(() {
            clase = value;
            _updateValue();
          });
        }),
        const SizedBox(height: 10),
        if (clase != null) _buildImage(),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> options, ValueChanged<int> onChanged) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        DropdownButton<int>(
          hint: const Text('Seleccione una clase'),
          value: clase,
          items: options.asMap().entries.map((entry) {
            int index = entry.key + 1;
            String text = entry.value;
            return DropdownMenuItem<int>(
              value: index,
              child: Text(text),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildImage() {
    String descripcion;
    if (clase == null) {
      return Container(); // No image when no option is selected
    }
    switch (clase) {
      case 1:
        descripcion = 'Distancia interincisivos >3 cm, sin dificultad en la laringoscopia';
        break;
      case 2:
        descripcion = 'Distancia interincisivos entre 2.6-3 cm, dificultad leve en la laringoscopia';
        break;
      case 3:
        descripcion = 'Distancia interincisivos entre 2-2.5 cm, dificultad moderada en la laringoscopia';
        break;
      case 4:
        descripcion = 'Distancia interincisivos <2 cm, dificultad en la laringoscopia';
        break;
      default:
        descripcion = '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/interincisivo.png'),
        const SizedBox(height: 10),
        Text(descripcion),
      ],
    );
  }
}