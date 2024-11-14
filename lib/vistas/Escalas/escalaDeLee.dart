import 'package:flutter/material.dart';

class LeeScaleWidget extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const LeeScaleWidget({Key? key, required this.onValueUpdated}) : super(key: key);

  @override
  State<LeeScaleWidget> createState() => _LeeScaleWidgetState();
}

class _LeeScaleWidgetState extends State<LeeScaleWidget> {
  final List<int> selectedRows = [];

  void updateTextField() {
    if (selectedRows.isEmpty) {
      widget.onValueUpdated('ÍNDICE DE LEE', '0 puntos, 3.9% de probabilidad de presentar complicaciones cardiacas mayores');
    } else if (selectedRows.length == 1) {
      widget.onValueUpdated('ÍNDICE DE LEE', '1 punto, 6% de probabilidad de presentar complicaciones cardiacas mayores');
    } else if (selectedRows.length == 2) {
      widget.onValueUpdated('ÍNDICE DE LEE', '2 puntos, 10.1% de probabilidad de presentar complicaciones cardiacas mayores');
    } else {
      widget.onValueUpdated('ÍNDICE DE LEE', '3 o más puntos, 15% de probabilidad de presentar complicaciones cardiacas mayores');
    }
  }

  void toggleRowSelection(int index) {
    setState(() {
      if (selectedRows.contains(index)) {
        selectedRows.remove(index);
      } else {
        selectedRows.add(index);
      }
      updateTextField();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Escala De Lee',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Column(
            children: List.generate(_descriptions.length, (index) {
              return _buildDataRow(index, _descriptions[index]);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(int index, String description) {
    return CheckboxListTile(
      title: Text(description),
      value: selectedRows.contains(index),
      onChanged: (selected) {
        toggleRowSelection(index);
      },
    );
  }

  static const List<String> _descriptions = [
    'Cirugía de alto riesgo: Torácica, abdominal, aórtica, vascular renal, vascular mesentérica.',
    'Cardiopatía isquémica: Historia de infarto al miocardio, prueba de ejercicio positiva,\n precordalgia secundaria a isquemia miocárdica, tratamiento con nitratos, electrocardiograma con ondas Q patológicas',
    'Insuficiencia cardíaca congestiva: insuficiencia cardíaca izquierda al examen físico, historia de disnea paroxística nocturna, \nhistoria de edema agudo pulmonar, presencia de tercer ruido o crépitos bilaterales',
    'Historia de enfermedad cerebrovascular: crisis isquémica transitoria, accidente cerebrovascular.',
    'Tratamiento preoperatorio con insulina.',
    'Creatinina sérica preoperatoria > 2mg/kg.',
  ];
}