import 'package:flutter/material.dart';

class EscalaMallampati extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaMallampati({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaMallampatiState createState() => _EscalaMallampatiState();
}

class _EscalaMallampatiState extends State<EscalaMallampati> {
  int grado = 1;

  void _updateValue() {
    String descripcion;
    switch (grado) {
      case 1:
        descripcion = 'Visualización de paladar blando, úvula y pilares amigdalinos';
        break;
      case 2:
        descripcion = 'Visualización de paladar blando y úvula';
        break;
      case 3:
        descripcion = 'Visualización de paladar blando y base de la úvula';
        break;
      case 4:
        descripcion = 'Visualización sólo de paladar duro';
        break;
      default:
        descripcion = '';
    }
    String result = 'Escala de MALLAMPATI: Grado $grado, $descripcion';
    widget.updateScaleValue('Escala de Mallampati', result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Escala de Mallampati modificada por Samsoon y Young',
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
        _buildImage(grado),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> options, ValueChanged<int> onChanged) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        DropdownButton<int>(
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
        imagePath = 'assets/images/mallapatigrado1.png';
        descripcion = 'Visualización de paladar blando, úvula y pilares amigdalinos';
        break;
      case 2:
        imagePath = 'assets/images/mallapatigrado2.png';
        descripcion = 'Visualización de paladar blando y úvula';
        break;
      case 3:
        imagePath = 'assets/images/mallapatigrado3.png';
        descripcion = 'Visualización de paladar blando y base de la úvula';
        break;
      case 4:
        imagePath = 'assets/images/mallapatigrado4.png';
        descripcion = 'Visualización sólo de paladar duro';
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