import 'package:flutter/material.dart';

class EscalaPatilAldreti extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaPatilAldreti({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaPatilAldretiState createState() => _EscalaPatilAldretiState();
}

class _EscalaPatilAldretiState extends State<EscalaPatilAldreti> {
  int? clase; // Valor inicial nulo para el placeholder

  void _updateValue() {
    String descripcion;
    switch (clase) {
      case 1:
        descripcion = 'Distancia tiromentoniana >6.5 cm, sin dificultad en la laringoscopia';
        break;
      case 2:
        descripcion = 'Distancia tiromentoniana entre 6-6.5 cm, cierto grado de dificultad en la laringoscopia';
        break;
      case 3:
        descripcion = 'Distancia tiromentoniana <6 cm, dificultad en la laringoscopia';
        break;
      default:
        descripcion = '';
    }
    String result = '$descripcion';
    widget.updateScaleValue('Escala de Patil - Aldreti', result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Escala de Patil – Aldreti (Distancia tiromentoniana)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        _buildDropdown('Clase', [
          'Clase I, Distancia de 6.5 cm o más',
          'Clase II, Distancia de 6-6.5 cm',
          'Clase III, Distancia de menos de 6 cm',
        ], (value) {
          setState(() {
            clase = value;
            _updateValue();
          });
        }),
        const SizedBox(height: 10),
        _buildImage(),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> options, ValueChanged<int> onChanged) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: clase,
          hint: const Text("Elige una opción"), // Add hint
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
    if (clase == null) {
      return Container(); // No image when no option is selected
    }
    String descripcion;
    switch (clase) {
      case 1:
        descripcion = 'Distancia tiromentoniana >6.5 cm, sin dificultad en la laringoscopia';
        break;
      case 2:
        descripcion = 'Distancia tiromentoniana entre 6-6.5 cm, cierto grado de dificultad en la laringoscopia';
        break;
      case 3:
        descripcion = 'Distancia tiromentoniana <6 cm, dificultad en la laringoscopia';
        break;
      default:
        descripcion = '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/patilAldreti.png'),
        const SizedBox(height: 10),
        Text(descripcion),
      ],
    );
  }
}