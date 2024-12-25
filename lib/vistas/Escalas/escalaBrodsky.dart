import 'package:flutter/material.dart';

class EscalaBrodsky extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaBrodsky({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaBrodskyState createState() => _EscalaBrodskyState();
}

class _EscalaBrodskyState extends State<EscalaBrodsky> {
  int? seleccion;

  void _updateValue() {
    String descripcion;
    switch (seleccion) {
      case 1:
        descripcion = 'Circunferencia de cuello < 43 cm, sin dificultad para la intubación';
        break;
      case 2:
        descripcion = 'Circunferencia de cuello > 43 cm, probable intubación difícil';
        break;
      default:
        descripcion = '';
    }
    String result = 'Índice de BRODSKY: $descripcion';
    widget.updateScaleValue('Índice de Brodsky', result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Índice de Brodsky',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        _buildDropdown('Circunferencia de cuello', [
          '< 43 cm',
          '> 43 cm',
        ], (value) {
          setState(() {
            seleccion = value;
            _updateValue();
          });
        }),
        const SizedBox(height: 10),
        if (seleccion != null) _buildImage(seleccion!),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> options, ValueChanged<int> onChanged) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        DropdownButton<int>(
          hint: const Text('Seleccione una opción'),
          value: seleccion,
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

  Widget _buildImage(int seleccion) {
    String imagePath;
    String descripcion;
    switch (seleccion) {
      case 1:
        imagePath = 'assets/images/brodsky1.png';
        descripcion = 'Circunferencia de cuello < 43 cm, sin dificultad para la intubación';
        break;
      case 2:
        imagePath = 'assets/images/brodsky2.png';
        descripcion = 'Circunferencia de cuello > 43 cm, probable intubación difícil';
        break;
      default:
        imagePath = '';
        descripcion = '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Image.asset(imagePath)),
        const SizedBox(height: 10),
        Text(descripcion),
      ],
    );
  }
}