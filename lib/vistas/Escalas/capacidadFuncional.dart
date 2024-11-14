import 'package:flutter/material.dart';

class CapacidadFuncional extends StatefulWidget {
  final void Function(String, String) onValueUpdated;
  const CapacidadFuncional({super.key, required this.onValueUpdated});

  @override
  State<CapacidadFuncional> createState() => _CapacidadFuncionalState();
}

class _CapacidadFuncionalState extends State<CapacidadFuncional> {
  int? selectedRow;

  void updateTextField() {
    setState(() {
      if (selectedRow == null) {
      } else {
        widget.onValueUpdated(
            'ESCALA DE CAPACIDAD FUNCIONAL', getCapacity(selectedRow!));
      }
    });
  }

  String getCapacity(int index) {
    switch (index) {
      case 0:
        return 'Capacidad excelente 7-10';
      case 1:
        return 'Capacidad buena 5-7';
      case 2:
        return 'Capacidad aceptable 2-5';
      case 3:
        return 'Capacidad mala <2';
      default:
        return '';
    }
  }

  void toggleRowSelection(int index) {
    setState(() {
      if (selectedRow == index) {
        selectedRow = null;
      } else {
        selectedRow = index;
      }
      updateTextField();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Capacidad Funcional',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataRowMaxHeight: double.infinity,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'METS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'ACTIVIDAD',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'NIHA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: List<DataRow>.generate(
              4,
              (index) => DataRow(
                selected: selectedRow == index,
                onSelectChanged: (_) => toggleRowSelection(index),
                cells: <DataCell>[
                  DataCell(Text(getCapacity(index))),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getActivities(index),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text(getNIHA(index))),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getActivities(int index) {
    switch (index) {
      case 0:
        return '- Actividades exteriores moderadas\n'
            '- Bailar, correr, deportes al aire libre\n'
            '- Transportar objetos de aproximadamente 36kg\n'
            '- Caminar aproximadamente 7km/hr\n'
            '- Transportar aproximadamente 10kg /8 escalones';
      case 1:
        return '- Relaciones sexuales completas sin síntomas\n'
            '- Caminar aproximadamente 6km/hr\n'
            '- Trabajos domésticos pesados (mover muebles)\n'
            '- Patinar, bailar';
      case 2:
        return '- Andar en terreno llano\n'
            '- Subir un piso de escaleras\n'
            '- Hacer trabajo doméstico ligero (limpiar, aspirar)\n'
            '- Actividades recreativas (golf)\n'
            '- Ducharse, vestirse, tender la cama\n'
            '- Caminar aproximadamente 4km/hr';
      case 3:
        return '- Incapacidad para realizar tareas discretas\n'
            '- Limitado a permanecer en domicilio';
      default:
        return '';
    }
  }

  String getNIHA(int index) {
    switch (index) {
      case 0:
        return 'I';
      case 1:
        return 'II';
      case 2:
        return 'III';
      case 3:
        return 'IV';
      default:
        return '';
    }
  }
}
