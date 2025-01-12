import 'package:flutter/material.dart';

class EscalaBellhouseDore extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaBellhouseDore({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaBellhouseDoreState createState() => _EscalaBellhouseDoreState();
}

class _EscalaBellhouseDoreState extends State<EscalaBellhouseDore> {
  int? grado;

  void _updateValue() {
    String descripcion;
    switch (grado) {
      case 1:
        descripcion = 'Ninguna limitación. Superior a 35°';
        break;
      case 2:
        descripcion = '1/3 de limitación';
        break;
      case 3:
        descripcion = '2/3 de limitación';
        break;
      case 4:
        descripcion = 'Limitación completa';
        break;
      default:
        descripcion = '';
    }
    String result = "$grado, $descripcion";
    widget.updateScaleValue('Escala Bellhouse / Dore', result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escala Bellhouse / Dore',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        _buildDropdown('Grado', [
          'Grado I',
          'Grado II',
          'Grado III',
          'Grado IV',
        ], (value) {
          setState(() {
            grado = value;
            _updateValue();
          });
        }),
        const SizedBox(height: 10),
        if (grado != null) _buildImage(),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> options, ValueChanged<int> onChanged) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        DropdownButton<int>(
          hint: const Text('Seleccione un grado'),
          value: grado,
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
    if (grado == null) {
      return Container(); // No image when no option is selected
    }
    switch (grado) {
      case 1:
        descripcion = 'Ninguna limitación. Superior a 35°';
        break;
      case 2:
        descripcion = '1/3 de limitación';
        break;
      case 3:
        descripcion = '2/3 de limitación';
        break;
      case 4:
        descripcion = 'Limitación completa';
        break;
      default:
        descripcion = '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/bellhouse.png'),
        const SizedBox(height: 10),
        Text(descripcion),
      ],
    );
  }
}