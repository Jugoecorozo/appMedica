import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    // Resto de cirugías
    // Puedes completar esta sección con las mismas escalas o agregar escalas adicionales según sea necesario
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
                        Text(scale),
                        SizedBox(height: 8),
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
  TextEditingController textFieldController = TextEditingController();

  void updateTextField(String value) {
    setState(() {
      textFieldController.text = value;
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
                DataCell(SizedBox(
                  width: 300,
                  child: GestureDetector(
                    onTap: () {
                      updateTextField('Riesgo quirúrgico bajo');
                    },
                    child: Text(
                      '- Cirugía superficial\n- Cirugía de mama\n- Odontología\n- Tiroides\n- Ojo\n- Reconstructiva\n- Carotídea en pacientes asintomáticos (endarterectomía o STENT carotídeo)\n- Ginecológica menor\n- Ortopédica menor (meniscectomía)\n- Urológica menor (Resección transuretral de próstata)',
                      textAlign: TextAlign.left,
                    ),
                  ),
                )),
                DataCell(SizedBox(
                  width: 300,
                  child: GestureDetector(
                    onTap: () {
                      updateTextField('Riesgo quirúrgico intermedio');
                    },
                    child: Text(
                      '- Intraperitoneal (esplenectomía, reparación de hernia hiatal, colecistectomía)\n- Carotídea en pacientes sintomáticos (endarterectomía o STENT carotídeo)\n- Angioplastia arterial periférica\n- Reparación endovascular de aneurisma\n- Cirugía de cabeza y cuello\n- Neurocirugía\n- Ortopedia mayor (cadera, columna)\n- Ginecológica mayor\n- Urológica mayor\n- Trasplante renal\n- Intratorácica (no mayor)',
                      textAlign: TextAlign.left,
                    ),
                  ),
                )),
                DataCell(SizedBox(
                  width: 300,
                  child: GestureDetector(
                    onTap: () {
                      updateTextField('Riesgo quirúrgico alto');
                    },
                    child: Text(
                      '- Cirugía aortica y vascular mayor\n- Cirugía pancreática-duodenal\n- Revascularización abierta de miembros inferiores o amputación o troboembolectomía\n- Resección hepática o cirugía de la vía biliar\n- Esofagectomía\n- Reparación de perforación intestinal\n- Resección adrenal\n- Cistectomía total\n- Neumonectomía\n- Trasplante hepático\n- Trasplante pulmonar',
                      textAlign: TextAlign.left,
                    ),
                  ),
                )),
              ]),
            ],
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
      ],
    );
  }
}

class LeeScaleWidget extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  LeeScaleWidget({super.key, required this.onValueUpdated});

  @override
  State<LeeScaleWidget> createState() => _LeeScaleWidgetState();
}

class _LeeScaleWidgetState extends State<LeeScaleWidget> {
  TextEditingController textFieldController = TextEditingController();

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
            columns: <DataColumn>[
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
                cells: <DataCell>[
                  DataCell(Text(
                      'Cirugía de alto riesgo: Torácica, abdominal,  aórtica, vascular renal, vascular mesentérica.')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                      'Cardiopatía isquémica: Historia de infarto al miocardio, prueba de ejercicio positiva,\n precordalgia secundaria a isquemia miocárdica, tratamiento con nitratos, electrocardiograma con ondas Q patológicas')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                      'Insuficiencia cardíaca congestiva: insuficiencia cardíaca izquierda al examen físico, historia de disnea paroxística nocturna, \nhistoria de edema agudo pulmonar, presencia de tercer ruido o crépitos bilaterales')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                      'Historia de enfermedad cerebrovascular: crisis isquémica transitoria, accidente cerebrovascular.')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Tratamiento preoperatorio con insulina.')),
                  DataCell(Text('1')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Creatinina sérica preoperatoria > 2mg/kg.')),
                  DataCell(Text('1')),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 20),
        TextField(
          controller: textFieldController,
          decoration: const InputDecoration(
            hintText: 'Ingrese un valor',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        // Aquí puedes agregar los campos y la tabla para la Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)
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
  TextEditingController textFieldController = TextEditingController();

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
    columns: <DataColumn>[
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
    rows: <DataRow>[
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Capacidad excelente 7-10')),
          DataCell(Text(
    '- Actividades exteriores moderadas\n'
    '- Bailar, correr, deportes al aire libre\n'
    '- Transportar objetos de aproximadamente 36kg\n'
    '- Caminar aproximadamente 7km/hr\n'
    '- Transportar aproximadamente 10kg /8 escalones',
  )
          ),
          DataCell(Text('I')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Capacidad buena 5-7')),
          DataCell(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Text(
    '- Relaciones sexuales completas sin síntomas\n'
    '- Caminar aproximadamente 6km/hr\n'
    '- Trabajos domésticos pesados (mover muebles)\n'
    '- Patinar, bailar',
  )
              ],
            ),
          ),
          DataCell(Text('II')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Capacidad aceptable 2-5')),
          DataCell(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
    '- Andar en terreno llano\n'
    '- Subir un piso de escaleras\n'
    '- Hacer trabajo doméstico ligero (limpiar, aspirar)\n'
    '- Actividades recreativas (golf)\n'
    '- Ducharse, vestirse, tender la cama\n'
    '- Caminar aproximadamente 4km/hr',
  )
              ],
            ),
          ),
          DataCell(Text('III')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('Capacidad mala <2')),
          DataCell(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
    '- Incapacidad para realizar tareas discretas\n'
    '- Limitado a permanecer en domicilio',
  )
              ],
            ),
          ),
          DataCell(Text('IV')),
        ],
      ),
    ],
  ),
),



        SizedBox(height: 20),
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

class Caprini extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Caprini({super.key, required this.onValueUpdated});

  @override
  State<Caprini> createState() => _CapriniState();
}

class _CapriniState extends State<Caprini> {
  TextEditingController textFieldController = TextEditingController();

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
        SizedBox(height: 20),
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

class Appel extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Appel({super.key, required this.onValueUpdated});

  @override
  State<Appel> createState() => _AppelState();
}

class _AppelState extends State<Appel> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Escala De APFEL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 20),
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

class Barthel extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Barthel({super.key, required this.onValueUpdated});

  @override
  State<Barthel> createState() => _BarthelState();
}

class _BarthelState extends State<Barthel> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        const Text(
          'Escala De Barthel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
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
        SizedBox(height: 20),
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
        SizedBox(height: 20),
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
        SizedBox(height: 20),
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
        SizedBox(height: 20),
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
