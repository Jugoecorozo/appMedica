import 'package:flutter/material.dart';

class EscalaProtrusionMandibular extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaProtrusionMandibular({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaProtrusionMandibularState createState() => _EscalaProtrusionMandibularState();
}

class _EscalaProtrusionMandibularState extends State<EscalaProtrusionMandibular> {
  int? grado;

  void _updateValue() {
    String descripcion;
    switch (grado) {
      case 1:
        descripcion = 'Los incisivos inferiores muerden el labio superior, tapando completamente la mucosa del labio';
        break;
      case 2:
        descripcion = 'Los incisivos inferiores muerden el labio superior, pero permiten la visualización parcial de la mucosa';
        break;
      case 3:
        descripcion = 'Los incisivos inferiores no pueden morder el labio superior';
        break;
      default:
        descripcion = '';
    }
    String result = '$grado, $descripcion';
    widget.updateScaleValue('Protrusión Mandibular', result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Protrusión Mandibular',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        _buildDropdown('Grado', [
          'Grado I',
          'Grado II',
          'Grado III',
        ], (value) {
          setState(() {
            grado = value;
            _updateValue();
          });
        }),
        const SizedBox(height: 10),
        if (grado != null) _buildImage(grado!),
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

  Widget _buildImage(int grado) {
    String imagePath;
    String descripcion;
    switch (grado) {
      case 1:
        imagePath = 'assets/images/protrusionmandibulargrado1.png';
        descripcion = 'Los incisivos inferiores muerden el labio superior, tapando completamente la mucosa del labio';
        break;
      case 2:
        imagePath = 'assets/images/protrusionmandibulargrado2.png';
        descripcion = 'Los incisivos inferiores muerden el labio superior, pero permiten la visualización parcial de la mucosa';
        break;
      case 3:
        imagePath = 'assets/images/protrusionmandibulargrado3.png';
        descripcion = 'Los incisivos inferiores no pueden morder el labio superior';
        break;
      default:
        imagePath = '';
        descripcion = '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath),
        const SizedBox(height: 10),
        Text(descripcion),
      ],
    );
  }
}