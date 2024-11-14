import 'package:flutter/material.dart';


class StopBang extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const StopBang({super.key, required this.onValueUpdated});

  @override
  State<StopBang> createState() => _StopBangState();
}

class _StopBangState extends State<StopBang> {
  Map<String, bool> answers = {
    'S': false,
    'T': false,
    'O': false,
    'P': false,
    'B': false,
    'A': false,
    'N': false,
    'G': false,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Escala De STOP-BANG',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        DataTable(
          dataRowMaxHeight: double.infinity,
          columns: const [
            DataColumn(label: Text('Pregunta')),
            DataColumn(label: Text('Descripción')),
          ],
          rows: answers.keys.map((key) {
            return DataRow(
              cells: [
                DataCell(Text(key)),
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getSubtitleByKey(key),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(_getDescriptionByKey(key)),
                    ],
                  ),
                ),
              ],
              selected: answers[key]!,
              onSelectChanged: (selected) {
                setState(() {
                  answers[key] = selected!;
                  _updateRisk();
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getSubtitleByKey(String key) {
    switch (key) {
      case 'S':
        return 'Snore';
      case 'T':
        return 'Tired';
      case 'O':
        return 'Observed apnea';
      case 'P':
        return 'Pressure';
      case 'B':
        return 'Body mass index';
      case 'A':
        return 'Age';
      case 'N':
        return 'Neck';
      case 'G':
        return 'Gender';
      default:
        return '';
    }
  }

  String _getDescriptionByKey(String key) {
    switch (key) {
      case 'S':
        return '¿Usted ronca alto?, ¿más alto que en una conversación o tan alto que es posible oírlo con la puerta cerrada?';
      case 'T':
        return '¿Usted está siempre cansado?, ¿duerme durante el día?';
      case 'O':
        return '¿Le han comentado que parece que deja de respirar cuando está dormido?';
      case 'P':
        return '¿Sufre de presión alta?, ¿usted es hipertenso?';
      case 'B':
        return 'Índice de masa corporal > 35 kg/m2';
      case 'A':
        return 'Edad por encima de los 50 años';
      case 'N':
        return 'Circunferencia de cuello mayor a 40 cm';
      case 'G':
        return 'Masculino';
      default:
        return '';
    }
  }

  void _updateRisk() {
    int positiveAnswers = answers.values.where((element) => element).length;
    if (positiveAnswers > 3) {
      widget.onValueUpdated('ESCALA DE STOP-BANG: ', 'Alto Riesgo');
    } else {
      widget.onValueUpdated('ESCALA DE STOP-BANG: ', 'Bajo Riesgo');
    }
  }
}