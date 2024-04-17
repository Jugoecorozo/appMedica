import 'package:flutter/material.dart';

class SurgeryRiskCalculator extends StatefulWidget {
  const SurgeryRiskCalculator({super.key});

  @override
  _SurgeryRiskCalculatorState createState() => _SurgeryRiskCalculatorState();
}

class _SurgeryRiskCalculatorState extends State<SurgeryRiskCalculator> {
  String? selectedSurgery;
  Map<String, String> scaleValues =
      {}; // Mapa para almacenar los valores ingresados en los TextField

  updateScaleValue(String scale, String value) {
    setState(() {
      scaleValues[scale] = value;
    });
  }

  List<String> surgeries = [
  'Neurocirugía',
  'Cirugía de cabeza y cuello',
  'Cirugía cardiovascular',
  'Cirugía de tórax',
  'Cirugía general',
  'Cirugía digestiva oncológica',
  'Cirugía bariátrica',
  'Cirugía ginecológica',
  'Cirugía ortopédica',
  'Cirugía urológica',
  'Cirugía plástica',
];

 Map<String, List<String>> surgeryToScales = {
  'Neurocirugía': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala de Barthel',
    'Escala ARISCAT',
  ],
  'Cirugía de cabeza y cuello': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
  ],
  'Cirugía cardiovascular': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
  ],
  'Cirugía de tórax': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
  ],
  'Cirugía general': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
    'EUROSCORE II',
  ],
  'Cirugía digestiva oncológica': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
  ],
  'Cirugía bariátrica': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
  ],
  'Cirugía ginecológica': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
  ],
  'Cirugía ortopédica': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
    'STOP BANG',
  ],
  'Cirugía urológica': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
  ],
  'Cirugía plástica': [
    'Escala De Glance',
    'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
    'Escala De Capacidad Funcional',
    'Escala Caprini Para Riesgo De Trombosis Venosa',
    'Escala De APFEL',
    'Escala ARISCAT',
  ],
};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escalas de Riesgo por Cirugía'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: selectedSurgery,
                hint: const Text('Selecciona una cirugía'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSurgery = newValue;
                    scaleValues.clear();
                  });
                },
                items: surgeries.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              if (selectedSurgery != null &&
                  surgeryToScales[selectedSurgery!] != null)
                ...surgeryToScales[selectedSurgery!]!.map((scale) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        // Aquí puedes colocar el widget específico para cada escala
                        if (scale == 'Escala De Glance')
                          GlanceScaleWidget(onValueUpdated: updateScaleValue),
                        if (scale ==
                            'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)')
                          LeeScaleWidget(onValueUpdated: updateScaleValue),
                        if (scale == 'Escala De Capacidad Funcional')
                          CapacidadFuncional(onValueUpdated: updateScaleValue),
                        if (scale ==
                            'Escala Caprini Para Riesgo De Trombosis Venosa')
                          Caprini(onValueUpdated: updateScaleValue),
                        if (scale == 'Escala De APFEL')
                          Appel(onValueUpdated: updateScaleValue),
                        if (scale == 'Escala de Barthel')
                          Barthel(onValueUpdated: updateScaleValue),
                        if (scale == 'Escala ARISCAT')
                          Ariscat(onValueUpdated: updateScaleValue),
                        if (scale == 'Escala De STOP-BANG')
                          StopBang(onValueUpdated: updateScaleValue),
                        if (scale == 'Escala De ToracoScore')
                          ToracoScore(onValueUpdated: updateScaleValue),
                        if (scale == 'Escala De EuroScore II')
                          EuroScoreII(onValueUpdated: updateScaleValue),
                        // Añade más condicionales según sea necesario para otras escalas
                      ],
                    ),
                  );
                }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print('Tipo de cirugía: $selectedSurgery');
                  print('Resultados de las escalas:');
                  scaleValues.forEach((scale, value) {
                    print('$scale: $value');
                  });
                },
                child: const Text('Calcular Riesgo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlanceScaleWidget extends StatefulWidget {
  final void Function(String, String) onValueUpdated;
  const GlanceScaleWidget({super.key, required this.onValueUpdated});

  @override
  _GlanceScaleWidgetState createState() => _GlanceScaleWidgetState();
}

class _GlanceScaleWidgetState extends State<GlanceScaleWidget> {
  int selectedCellIndex = -1;

  void updateTextField(String value) {
    setState(() {
      widget.onValueUpdated('Escala De Glance', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escala De Glance',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataRowMaxHeight: 300,
            columns: const [
              DataColumn(label: Text('RIESGO BAJO (<1%)')),
              DataColumn(label: Text('RIESGO INTERMEDIO  (1-5%)')),
              DataColumn(label: Text('RIESGO ALTO (>5%)')),
            ],
            rows: [
              DataRow(cells: [
                buildDataCell(
                  'Riesgo quirúrgico bajo',
                  '- Cirugía superficial\n- Cirugía de mama\n- Odontología\n- Tiroides\n- Ojo\n- Reconstructiva\n- Carotídea en pacientes asintomáticos (endarterectomía o STENT carotídeo)\n- Ginecológica menor\n- Ortopédica menor (meniscectomía)\n- Urológica menor (Resección transuretral de próstata)',
                  0,
                ),
                buildDataCell(
                  'Riesgo quirúrgico intermedio',
                  '- Intraperitoneal (esplenectomía, reparación de hernia hiatal, colecistectomía)\n- Carotídea en pacientes sintomáticos (endarterectomía o STENT carotídeo)\n- Angioplastia arterial periférica\n- Reparación endovascular de aneurisma\n- Cirugía de cabeza y cuello\n- Neurocirugía\n- Ortopedia mayor (cadera, columna)\n- Ginecológica mayor\n- Urológica mayor\n- Trasplante renal\n- Intratorácica (no mayor)',
                  1,
                ),
                buildDataCell(
                  'Riesgo quirúrgico alto',
                  '- Cirugía aortica y vascular mayor\n- Cirugía pancreática-duodenal\n- Revascularización abierta de miembros inferiores o amputación o troboembolectomía\n- Resección hepática o cirugía de la vía biliar\n- Esofagectomía\n- Reparación de perforación intestinal\n- Resección adrenal\n- Cistectomía total\n- Neumonectomía\n- Trasplante hepático\n- Trasplante pulmonar',
                  2,
                ),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  DataCell buildDataCell(String title, String content, int index) {
    final isSelected = selectedCellIndex == index;

    return DataCell(
      GestureDetector(
        onTap: () {
          setState(() {
            selectedCellIndex = index;
          });
          updateTextField(title);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.withOpacity(0.2)
                : null, // Cambia el color de fondo si está seleccionado
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(8.0),
          width: 300,
          child: Text(
            content,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}

class LeeScaleWidget extends StatefulWidget {
  final void Function(String, String) onValueUpdated;
  const LeeScaleWidget({super.key, required this.onValueUpdated});

  @override
  State<LeeScaleWidget> createState() => _LeeScaleWidgetState();
}

class _LeeScaleWidgetState extends State<LeeScaleWidget> {

  List<int> selectedRows = [];

  void updateTextField() {
    setState(() {
      if (selectedRows.isEmpty) {
        widget.onValueUpdated('Escala De Lee', 'Riesgo bajo');
      } else if (selectedRows.length == 1) {
        widget.onValueUpdated('Escala De Lee', 'Riesgo moderado');
      } else if (selectedRows.length == 2) {
        widget.onValueUpdated('Escala De Lee', 'Riesgo medio/alto');
      } else {
        widget.onValueUpdated('Escala De Lee', 'Riesgo alto');
      }
    });
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
    return Column(
      children: [
        const Text(
          'Escala De Lee',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'CRITERIOS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'PUNTOS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: <DataRow>[
              DataRow(
                selected: selectedRows.contains(0),
                onSelectChanged: (selected) {
                  toggleRowSelection(0);
                },
                cells: const <DataCell>[
                  DataCell(Text(
                      'Cirugía de alto riesgo: Torácica, abdominal,  aórtica, vascular renal, vascular mesentérica.')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                selected: selectedRows.contains(1),
                onSelectChanged: (selected) {
                  toggleRowSelection(1);
                },
                cells: const <DataCell>[
                  DataCell(Text(
                      'Cardiopatía isquémica: Historia de infarto al miocardio, prueba de ejercicio positiva,\n precordalgia secundaria a isquemia miocárdica, tratamiento con nitratos, electrocardiograma con ondas Q patológicas')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                selected: selectedRows.contains(2),
                onSelectChanged: (selected) {
                  toggleRowSelection(2);
                },
                cells: const <DataCell>[
                  DataCell(Text(
                      'Insuficiencia cardíaca congestiva: insuficiencia cardíaca izquierda al examen físico, historia de disnea paroxística nocturna, \nhistoria de edema agudo pulmonar, presencia de tercer ruido o crépitos bilaterales')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                selected: selectedRows.contains(3),
                onSelectChanged: (selected) {
                  toggleRowSelection(3);
                },
                cells: const <DataCell>[
                  DataCell(Text(
                      'Historia de enfermedad cerebrovascular: crisis isquémica transitoria, accidente cerebrovascular.')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                selected: selectedRows.contains(4),
                onSelectChanged: (selected) {
                  toggleRowSelection(4);
                },
                cells: const <DataCell>[
                  DataCell(Text('Tratamiento preoperatorio con insulina.')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                selected: selectedRows.contains(5),
                onSelectChanged: (selected) {
                  toggleRowSelection(5);
                },
                cells: const <DataCell>[
                  DataCell(Text('Creatinina sérica preoperatoria > 2mg/kg.')),
                  DataCell(Text('1')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
        widget.onValueUpdated('Escala De Capacidad Funcional', getCapacity(selectedRow!));
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
            dataRowMaxHeight: 150,
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
class Caprini extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Caprini({Key? key, required this.onValueUpdated}) : super(key: key);

  @override
  State<Caprini> createState() => _CapriniState();
}

class _CapriniState extends State<Caprini> {
  String? selectedRiskFactor;

  DataRow _buildDataRow(List<String> data) {
    return DataRow(
      selected: selectedRiskFactor == data[0],
      onSelectChanged: (selected) {
        if (selected != null && selected) {
          setState(() {
            selectedRiskFactor = data[0];
          });
          widget.onValueUpdated(
            'Escala Caprini Para Riesgo De Trombosis Venosa',
            'Puntos: ${data[0]}, Categoría: ${data[1]}, Riesgo: ${data[2]}, Recomendaciones: ${data[3]}, Quimioprofilaxis: ${data[4]}',
          );
        }
      },
      cells: data.map((text) => DataCell(Text(text))).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Escala Caprini Para Riesgo De Trombosis Venosa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataRowMaxHeight: 190,
            columnSpacing: 20,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'PUNTOS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  '0',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  '1',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  '2',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  '3',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  '5',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Edad (Años)')),
                  DataCell(Text('<40')),
                  DataCell(Text('41-60')),
                  DataCell(Text('61-74')),
                  DataCell(Text('>75')),
                  DataCell(Text('')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Tipo de cirugía')),
                  DataCell(Text('')),
                  DataCell(Text('Menor')),
                  DataCell(
                    Text(
                      '- >45 min\n- Laparoscópica >45 min\n- Artroscópica',
                    ),
                  ),
                  DataCell(Text('')),
                  DataCell(
                    Text(
                      'Artroplastia electiva mayor de extremidades inferiores',
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Reciente <mes')),
                  DataCell(Text('')),
                  DataCell(
                    Text('- Cirugía mayor'
                        '\n- Insuficiencia cardiaca congestiva'
                        '\n- Sepsis'
                        '\n- Neumonía'
                        '\n- Embarazo o posparto'),
                  ),
                  DataCell(Text('Yeso inmovilizador')),
                  DataCell(Text('')),
                  DataCell(
                    Text(
                      '- Fractura de cadera, pelvis o pierna'
                      '\n- Infarto'
                      '\n- Politraumatismo'
                      '\n- Lesión aguda de médula espinal que causa parálisis',
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text('Enfermedad venosa o trastorno de la coagulación'),
                  ),
                  DataCell(Text('')),
                  DataCell(
                    Text('- Venas varicosas\n- Edema de miembros pélvicos'),
                  ),
                  DataCell(Text('Acceso venoso central actual')),
                  DataCell(
                    Text('- Antecedentes de TVP / EP'
                        '\n- Antecedentes familiares de trombosis'
                        '\n- Factor V Leiden positivo'
                        '\n- Homocisteína sérica elevada'
                        '\n- Anticoagulante lúpico positivo'
                        '\n- Anticuerpos anticardiolipina elevados'
                        '\n- Trombocitopenia inducida por heparina'
                        '\n- Otra trombofilia congénita o adquirida'),
                  ),
                  DataCell(Text('')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Morbilidades')),
                  DataCell(Text('')),
                  DataCell(
                    Text(
                      'Padecimiento médico actualmente en reposo en cama',
                    ),
                  ),
                  DataCell(Text('Paciente confinado en cama > 72 horas')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Otros')),
                  DataCell(Text('')),
                  DataCell(
                    Text(
                      '- Antecedentes de enfermedad inflamatoria intestinal'
                      '\n- Índice de masa corporal > 25'
                      '\n- Infarto agudo al miocardio'
                      '\n- Enfermedad pulmonar obstructiva crónica'
                      '\n- Otros factores de riesgo: anticonceptivos orales o reemplazo hormonal'
                      '\n- ≥3 abortos espontáneos o nacimiento prematuro con toxemia '
                      '\no lactante con retraso del crecimiento',
                    ),
                  ),
                  DataCell(Text('Neoplasia maligna actual o previa')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'PUNTOS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'CATEGORÍA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'RIESGO',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'RECOMENDACIONES',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'QUIMIOPROFILAXIS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: <DataRow>[
              _buildDataRow(['0', 'Muy bajo', 'Mínimo', '- Deambulación precoz o con ayuda del equipo\n- Dispositivos de compresión neumática o medias de compresión graduada', 'Hospitalización']),
              _buildDataRow(['1-2', 'Bajo', 'Mínimo', 'Dispositivos de compresión neumática con o sin medias de compresión graduada', 'Hospitalización']),
              _buildDataRow(['3-4', 'Moderado', '0.7%', 'Dispositivos de compresión neumática con o sin medias de compresión graduada', 'Hospitalización']),
              _buildDataRow(['5-6', 'Alto', '1.8%', 'Dispositivos de compresión neumática con dosis baja de heparina o heparina de bajo peso molecular', '7-10 días']),
              _buildDataRow(['7-8', 'Alto', '4%', 'Dispositivos de compresión neumática con dosis baja de heparina o heparina de bajo peso molecular', '7-10 días']),
              _buildDataRow(['>9', 'Muy alto', '10.7%', 'Dispositivos de compresión neumática con dosis baja de heparina o heparina de bajo peso molecular', '30 días']),
            ],
          ),
        ),
      ],
    );
  }
}


class Appel extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Appel({super.key, required this.onValueUpdated});

  @override
  State<Appel> createState() => _AppelState();
}

class _AppelState extends State<Appel> {
  String? selectedRiskFactor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
              scrollDirection: Axis.horizontal,

      child: Column(
        children: [
          const Text(
            'Escala De APFEL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          DataTable(
            columns: const [
              DataColumn(label: Text('Factor de riesgo')),
              DataColumn(label: Text('Puntos')),
              DataColumn(label: Text('%')),
              DataColumn(label: Text('Riesgo')),
            ],
            rows: [
              _buildRow('Ninguno', '0', '10', 'Muy bajo'),
              _buildRow('Sexo femenino', '1', '20', 'Bajo'),
              _buildRow('No fumador', '2', '40', 'Moderado'),
              _buildRow('Historia de náuseas y vómito postoperatorio o cinetosis', '3', '60', 'Alto'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String riskFactor, String points, String percentage, String risk) {
    return DataRow(
      selected: selectedRiskFactor == riskFactor,
      onSelectChanged: (selected) {
        if (selected != null && selected) {
          setState(() {
            selectedRiskFactor = riskFactor;
          });
          widget.onValueUpdated('Escala de Appel ', '$points puntos, riesgo: $risk ($percentage%) para presentar NVPO. ');
        }
      },
      cells: [
        DataCell(Text(riskFactor)),
        DataCell(Text(points)),
        DataCell(Text(percentage)),
        DataCell(Text(risk)),
      ],
    );
  }
}


class Barthel extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Barthel({Key? key, required this.onValueUpdated}) : super(key: key);

  @override
  State<Barthel> createState() => _BarthelState();
}

class _BarthelState extends State<Barthel> {
  String? selectedClassification;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Escala De Barthel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          _buildDataTable(),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Puntos')),
        DataColumn(label: Text('Clasificación')),
      ],
      rows: [
        _buildRow('0-20', 'Dependencia total'),
        _buildRow('21-60', 'Dependencia severa'),
        _buildRow('61-90', 'Dependencia moderada'),
        _buildRow('91-99', 'Dependencia leve'),
        _buildRow('100', 'Independiente'),
      ],
    );
  }

  DataRow _buildRow(String pointsRange, String classification) {
    return DataRow(
      selected: selectedClassification == classification,
      onSelectChanged: (selected) {
        if (selected != null && selected) {
          setState(() {
            selectedClassification = classification;
          });
          widget.onValueUpdated('Escala De Barthel','$pointsRange, $classification');
        }
      },
      cells: [
        DataCell(Text(pointsRange)),
        DataCell(Text(classification)),
      ],
    );
  }
}


class Ariscat extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Ariscat({super.key, required this.onValueUpdated});

  @override
  State<Ariscat> createState() => _AriscatState();
}

class _AriscatState extends State<Ariscat> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Escala De ARISCAT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: textFieldController,
          decoration: const InputDecoration(
            hintText: 'Ingrese un valor',
            border: OutlineInputBorder(),
          ),
        ),
        // Aquí puedes agregar los campos y la tabla para la Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)
      ],
    );
  }
}

class StopBang extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const StopBang({super.key, required this.onValueUpdated});

  @override
  State<StopBang> createState() => _StopBangState();
}

class _StopBangState extends State<StopBang> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Escala De STOP-BANG',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: textFieldController,
          decoration: const InputDecoration(
            hintText: 'Ingrese un valor',
            border: OutlineInputBorder(),
          ),
        ),
        // Aquí puedes agregar los campos y la tabla para la Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)
      ],
    );
  }
}

class ToracoScore extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const ToracoScore({super.key, required this.onValueUpdated});

  @override
  State<ToracoScore> createState() => _ToracoScoreState();
}

class _ToracoScoreState extends State<ToracoScore> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Escala De ToracoScore',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: textFieldController,
          decoration: const InputDecoration(
            hintText: 'Ingrese un valor',
            border: OutlineInputBorder(),
          ),
        ),
        // Aquí puedes agregar los campos y la tabla para la Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)
      ],
    );
  }
}

class EuroScoreII extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const EuroScoreII({super.key, required this.onValueUpdated});

  @override
  State<EuroScoreII> createState() => _EuroScoreIIState();
}

class _EuroScoreIIState extends State<EuroScoreII> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Escala De EuroScore II',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: textFieldController,
          decoration: const InputDecoration(
            hintText: 'Ingrese un valor',
            border: OutlineInputBorder(),
          ),
        ),
        // Aquí puedes agregar los campos y la tabla para la Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)
      ],
    );
  }
}
