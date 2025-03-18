import 'package:flutter/material.dart';

class EscalaMallampati extends StatefulWidget {
  final void Function(String, String) updateScaleValue;

  const EscalaMallampati({Key? key, required this.updateScaleValue}) : super(key: key);

  @override
  _EscalaMallampatiState createState() => _EscalaMallampatiState();
}

class _EscalaMallampatiState extends State<EscalaMallampati> {
  int? grado; // Valor inicial nulo para el placeholder

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
    String result = grado == null ? 'No evaluable' : 'Grado $grado, $descripcion';
    widget.updateScaleValue('Escala de MALLAMPATI:', result);
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
        _buildDropdown('Grado', {
          'No evaluable': null,
          'Grado I': 1,
          'Grado II': 2,
          'Grado III': 3,
          'Grado IV': 4,
        }, (value) {
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

  Widget _buildDropdown(String label, Map<String, int?> options, ValueChanged<int?> onChanged) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        DropdownButton<int?>(
          value: grado,
          hint: const Text("Selecciona una opción"), // Placeholder inicial
          items: options.entries.map((entry) {
            return DropdownMenuItem<int?>(
              value: entry.value,
              child: Text(entry.key),
            );
          }).toList(),
          onChanged: (value) {
            onChanged(value); // Actualiza el valor seleccionado
          },
        ),
      ],
    );
  }

  Widget _buildImage(int? grado) {
    if (grado == null) {
      return Container(); // No image when no option is selected
    }
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
