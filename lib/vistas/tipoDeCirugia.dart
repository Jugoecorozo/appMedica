import 'package:app_medica/vistas/antecedentesPersonales.dart';
import 'package:flutter/material.dart';


class SurgeryRiskCalculator extends StatefulWidget {
  final int patientAge;
  final double patientIMC;

  const SurgeryRiskCalculator({
    super.key,
    required this.patientAge,
    required this.patientIMC,
  });

  @override
  _SurgeryRiskCalculatorState createState() => _SurgeryRiskCalculatorState();
}

class _SurgeryRiskCalculatorState extends State<SurgeryRiskCalculator> {
  String? selectedSurgery;
  Map<String, String> scaleValues = {};

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
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía de cabeza y cuello': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía cardiovascular': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'EUROSCORE II',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía de tórax': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'TORACOSCORE',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía general': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía digestiva oncológica': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía bariátrica': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía ginecológica': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía ortopédica': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía urológica': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
    'Cirugía plástica': [
      'Escala De Glance',
      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)',
      'Escala De Capacidad Funcional',
      'Escala Caprini Para Riesgo De Trombosis Venosa',
      'Escala De APFEL',
      'Escala ARISCAT',
      'Escala De STOP-BANG',
      'Escala De Barthel'
    ],
  };

  @override
  Widget build(BuildContext context) {
    print('Edad del paciente: ${widget.patientAge}');
    print('IMC del paciente: ${widget.patientIMC}');
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
                  // Widget para la escala actual
                  Widget scaleWidget;
                  if (scale == 'Escala De Glance') {
                    scaleWidget = GlanceScaleWidget(onValueUpdated: updateScaleValue);
                  } else if (scale == 'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)') {
                    scaleWidget = LeeScaleWidget(onValueUpdated: updateScaleValue);
                  } else if (scale == 'Escala De Capacidad Funcional') {
                    scaleWidget = CapacidadFuncional(onValueUpdated: updateScaleValue);
                  } else if (scale == 'Escala Caprini Para Riesgo De Trombosis Venosa') {
                    scaleWidget = Caprini(onValueUpdated: updateScaleValue);
                  } else if (scale == 'Escala De APFEL') {
                    scaleWidget = Appel(onValueUpdated: updateScaleValue);
                  } else if (scale == 'Escala ARISCAT') {
                    scaleWidget = Ariscat(onValueUpdated: updateScaleValue);
                  } else if (scale == 'EUROSCORE II') {
                    scaleWidget = EuroScoreII(onValueUpdated: updateScaleValue);
                  } else if (scale == 'TORACOSCORE') {
                    scaleWidget = ToracoScore(onValueUpdated: updateScaleValue);
                  } else {
                    scaleWidget = const SizedBox();
                  }
                  
                  // Agregar STOP BANG si el IMC es mayor o igual a 30
                  if (scale == 'Escala De Barthel' && widget.patientAge > 65) {
                    scaleWidget = Column(
                      children: [
                        scaleWidget,
                        Barthel(onValueUpdated: updateScaleValue),
                      ],
                    );
                  } else if (scale == 'Escala De STOP-BANG' && widget.patientIMC >= 30) {
                    scaleWidget = Column(
                      children: [
                        scaleWidget,
                        StopBang(onValueUpdated: updateScaleValue),
                      ],
                    );
                  }
                  
                  // Retornar el widget de la escala actual
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: scaleWidget,
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
                  Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => const antecedentesPersonales())
);
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
            dataRowMaxHeight: double.infinity,
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
            dataRowMaxHeight: double.infinity,
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
        widget.onValueUpdated(
            'Escala De Capacidad Funcional', getCapacity(selectedRow!));
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

class Caprini extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Caprini({super.key, required this.onValueUpdated});

  @override
  State<Caprini> createState() => _CapriniState();
}

class _CapriniState extends State<Caprini> {
  String? selectedAge;
  String? selectedSurgeryType;
  int puntosTotales = 0;
  int nuevosPuntos = 0;
  

  bool cirugiaMayor = false;
  bool insuficienciaCardiaca = false;
  bool sepsis = false;
  bool neumonia = false;
  bool embarazoPostparto = false;
  bool yesoInmovilizador = false;
  bool fracturaCadera = false;
  bool infarto = false;
  bool politraumatismo = false;
  bool lesionMedulaEspinal = false;

  bool venasVaricosas = false;
  bool edemaPelvico = false;
  bool accesoVenosoCentral = false;
  bool antecedentesTVP_EP = false;
  bool antecedentesFamiliaresTrombosis = false;
  bool factorVLeiden = false;
  bool homocisteinaElevada = false;
  bool anticoagulanteLupico = false;
  bool anticuerposAnticardiolipina = false;
  bool trombocitopeniaInducidaHeparina = false;
  bool otraTrombofilia = false;

  bool padecimientoMedico = false;
  bool pacienteConfinadoCama = false;

  bool antecedentesEnfermedadInflamatoria = false;
  bool indiceMasaCorporal = false;
  bool infartoMiocardio = false;
  bool enfermedadPulmonarObstructiva = false;
  bool otrosFactoresRiesgo = false;

String calcularCategoria(int puntos) {
    if (puntos == 0) {
      return 'Muy bajo';
    } else if (puntos <= 2) {
      return 'Bajo';
    } else if (puntos <= 4) {
      return 'Moderado';
    } else if (puntos <= 6) {
      return 'Alto';
    } else if (puntos <= 8) {
      return 'Alto';
    } else {
      return 'Muy Alto';
    }
  }

  String calcularRiesgo(int puntos) {
    if (puntos == 0) {
      return 'Mínimo';
    } else if (puntos <= 2) {
      return 'Mínimo';
    } else if (puntos <= 4) {
      return '0.7%';
    } else if (puntos <= 6) {
      return '1.8%';
    } else if (puntos <= 8) {
      return '4%';
    } else {
      return '10.7%';
    }
  }

  String calcularRecomendaciones(int puntos) {
    if (puntos == 0) {
      return 'Deambulación precoz o con ayuda del equipo\n▪ Dispositivos de compresión neumática o medias de compresión graduada';
    } else if (puntos <= 2) {
      return 'Dispositivos de compresión neumática con o sin medias de compresión graduada';
    } else if (puntos <= 4) {
      return 'Dispositivos de compresión neumática con o sin medias de compresión graduada';
    } else if (puntos <= 6) {
      return 'Dispositivos de compresión neumática con dosis baja de heparina o heparina de bajo peso molecular';
    } else if (puntos <= 8) {
      return 'Dispositivos de compresión neumática con dosis baja de heparina o heparina de bajo peso molecular';
    } else {
      return 'Dispositivos de compresión neumática con dosis baja de heparina o heparina de bajo peso molecular';
    }
  }


  void _actualizarPuntos() {
    puntosTotales = 0;
    nuevosPuntos = 0;


    // Calcular puntos para la edad
    switch (selectedAge) {
      case '<40':
        puntosTotales += 0;
        break;
      case '41-60':
        puntosTotales += 1;
        break;
      case '61-74':
        puntosTotales += 2;
        break;
      case '>75':
        puntosTotales += 3;
        break;
    }

    // Calcular puntos para el tipo de cirugía
    switch (selectedSurgeryType) {
      case 'Menor':
        puntosTotales += 1;
        break;
      case '>45 min':
        puntosTotales += 2;
        break;
      case 'Laparoscópica':
        puntosTotales += 2;
        break;
      case 'Artroplastia':
        puntosTotales += 5;
        break;
    }

        puntosTotales = nuevosPuntos;

    String categoria = calcularCategoria(puntosTotales);
    String riesgo = calcularRiesgo(puntosTotales);
    String recomendaciones = calcularRecomendaciones(puntosTotales);



    // Calcular puntos para las preguntas
    puntosTotales += (cirugiaMayor ? 1 : 0) +
        (insuficienciaCardiaca ? 1 : 0) +
        (sepsis ? 1 : 0) +
        (neumonia ? 1 : 0) +
        (embarazoPostparto ? 1 : 0) +
        (yesoInmovilizador ? 2 : 0) +
        (fracturaCadera ? 5 : 0) +
        (infarto ? 5 : 0) +
        (politraumatismo ? 5 : 0) +
        (lesionMedulaEspinal ? 5 : 0) +
        (venasVaricosas ? 1 : 0) +
        (edemaPelvico ? 1 : 0) +
        (accesoVenosoCentral ? 2 : 0) +
        (antecedentesTVP_EP ? 3 : 0) +
        (antecedentesFamiliaresTrombosis ? 3 : 0) +
        (factorVLeiden ? 3 : 0) +
        (homocisteinaElevada ? 3 : 0) +
        (anticoagulanteLupico ? 3 : 0) +
        (anticuerposAnticardiolipina ? 3 : 0) +
        (trombocitopeniaInducidaHeparina ? 3 : 0) +
        (otraTrombofilia ? 3 : 0) +
        (padecimientoMedico ? 1 : 0) +
        (pacienteConfinadoCama ? 2 : 0) +
        (antecedentesEnfermedadInflamatoria ? 5 : 0) +
        (indiceMasaCorporal ? 5 : 0) +
        (infartoMiocardio ? 5 : 0) +
        (enfermedadPulmonarObstructiva ? 5 : 0) +
        (otrosFactoresRiesgo ? 5 : 0);

        String resultados =
        'Escala de Caprini: $puntosTotales puntos, riesgo $categoria ($riesgo) para presentar trombosis venosa, se recomienda $recomendaciones.';
    widget.onValueUpdated('Escala de Caprini', resultados);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escala De Caprini Para Riesgo De Trombosis Venosa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        DropdownButton<String>(
          hint: const Text('Selecciona una edad'),
          value: selectedAge,
          onChanged: (String? newValue) {
            setState(() {
              selectedAge = newValue;
              _actualizarPuntos();
            });
          },
          items: <String>[
            '<40',
            '41-60',
            '61-74',
            '>75',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        DropdownButton<String>(
          hint: const Text('Selecciona un tipo de cirugía'),
          value: selectedSurgeryType,
          onChanged: (String? newValue) {
            setState(() {
              selectedSurgeryType = newValue;
              _actualizarPuntos();
            });
          },
          items: <String>[
            'Menor',
            '>45 min',
            'Laparoscópica',
            'Artroplastia',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Text('Preguntas:'),
        CheckboxListTile(
          title: Text('¿Cirugía mayor?'),
          value: cirugiaMayor,
          onChanged: (bool? value) {
            setState(() {
              cirugiaMayor = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Insuficiencia cardiaca congestiva?'),
          value: insuficienciaCardiaca,
          onChanged: (bool? value) {
            setState(() {
              insuficienciaCardiaca = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Sepsis?'),
          value: sepsis,
          onChanged: (bool? value) {
            setState(() {
              sepsis = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Neumonía?'),
          value: neumonia,
          onChanged: (bool? value) {
            setState(() {
              neumonia = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Embarazo y postparto?'),
          value: embarazoPostparto,
          onChanged: (bool? value) {
            setState(() {
              embarazoPostparto = value!;
              _actualizarPuntos();
            });
          },
        ),
        Text('Enfermedad venosa o trastorno de la coagulación:'),
        CheckboxListTile(
          title: Text('¿Venas varicosas?'),
          value: venasVaricosas,
          onChanged: (bool? value) {
            setState(() {
              venasVaricosas = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Edema de miembros pélvicos?'),
          value: edemaPelvico,
          onChanged: (bool? value) {
            setState(() {
              edemaPelvico = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Acceso venoso central actual?'),
          value: accesoVenosoCentral,
          onChanged: (bool? value) {
            setState(() {
              accesoVenosoCentral = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Antecedentes de TVP / EP?'),
          value: antecedentesTVP_EP,
          onChanged: (bool? value) {
            setState(() {
              antecedentesTVP_EP = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Antecedentes familiares de trombosis?'),
          value: antecedentesFamiliaresTrombosis,
          onChanged: (bool? value) {
            setState(() {
              antecedentesFamiliaresTrombosis = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Factor V Leiden positivo?'),
          value: factorVLeiden,
          onChanged: (bool? value) {
            setState(() {
              factorVLeiden = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Homocisteína sérica elevada?'),
          value: homocisteinaElevada,
          onChanged: (bool? value) {
            setState(() {
              homocisteinaElevada = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Anticoagulante lúpico positivo?'),
          value: anticoagulanteLupico,
          onChanged: (bool? value) {
            setState(() {
              anticoagulanteLupico = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Anticuerpos anticardiolipina elevados?'),
          value: anticuerposAnticardiolipina,
          onChanged: (bool? value) {
            setState(() {
              anticuerposAnticardiolipina = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Trombocitopenia inducida por heparina?'),
          value: trombocitopeniaInducidaHeparina,
          onChanged: (bool? value) {
            setState(() {
              trombocitopeniaInducidaHeparina = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Otra trombofilia congénita o adquirida?'),
          value: otraTrombofilia,
          onChanged: (bool? value) {
            setState(() {
              otraTrombofilia = value!;
              _actualizarPuntos();
            });
          },
        ),
        Text('Morbilidades:'),
        CheckboxListTile(
          title: Text('¿Padecimiento médico, actualmente en reposo en cama?'),
          value: padecimientoMedico,
          onChanged: (bool? value) {
            setState(() {
              padecimientoMedico = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Paciente confinado en cama > 72 horas?'),
          value: pacienteConfinadoCama,
          onChanged: (bool? value) {
            setState(() {
              pacienteConfinadoCama = value!;
              _actualizarPuntos();
            });
          },
        ),
        Text('Otros:'),
        CheckboxListTile(
          title: Text('¿Antecedentes de enfermedad inflamatoria intestinal?'),
          value: antecedentesEnfermedadInflamatoria,
          onChanged: (bool? value) {
            setState(() {
              antecedentesEnfermedadInflamatoria = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Índice de masa corporal > 25?'),
          value: indiceMasaCorporal,
          onChanged: (bool? value) {
            setState(() {
              indiceMasaCorporal = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Infarto agudo al miocardio?'),
          value: infartoMiocardio,
          onChanged: (bool? value) {
            setState(() {
              infartoMiocardio = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Enfermedad pulmonar obstructiva crónica?'),
          value: enfermedadPulmonarObstructiva,
          onChanged: (bool? value) {
            setState(() {
              enfermedadPulmonarObstructiva = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: Text('¿Otros factores de riesgo? (anticonceptivos orales o reemplazo hormonal, ≥3 abortos espontáneos o nacimiento prematuro con toxemia o lactante con retraso del crecimiento)'),
          value: otrosFactoresRiesgo,
          onChanged: (bool? value) {
            setState(() {
              otrosFactoresRiesgo = value!;
              _actualizarPuntos();
            });
          },
        ),
        SizedBox(height: 20),
        Text('Puntos Totales: $puntosTotales'),
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
              _buildRow(
                  'Historia de náuseas y vómito postoperatorio o cinetosis',
                  '3',
                  '60',
                  'Alto'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
      String riskFactor, String points, String percentage, String risk) {
    return DataRow(
      selected: selectedRiskFactor == riskFactor,
      onSelectChanged: (selected) {
        if (selected != null && selected) {
          setState(() {
            selectedRiskFactor = riskFactor;
          });
          widget.onValueUpdated('Escala de Appel ',
              '$points puntos, riesgo: $risk ($percentage%) para presentar NVPO. ');
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

  const Barthel({super.key, required this.onValueUpdated});

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
      dataRowMaxHeight: double.infinity,
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
          widget.onValueUpdated(
              'Escala De Barthel', '$pointsRange, $classification');
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
            DataTable(
              dataRowMaxHeight: double.infinity,
              columnSpacing: 8,
              columns: const [
                DataColumn(label: Text('Factor de riesgo')),
                DataColumn(label: Text('')),
                DataColumn(label: Text('Puntos')),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Center(child: Text('Edad, años'))),
                  DataCell(Center(child: Text('<50\n51-80\n>80'))),
                  DataCell(Center(child: Text('0\n3\n16'))),
                ]),
                DataRow(cells: [
                  DataCell(Center(child: Text('Saturación parcial de oxígeno preoperatorio'))),
                  DataCell(Center(child: Text('>96%\n91-95%\n<90%'))),
                  DataCell(Center(child: Text('0\n8\n24'))),
                ]),
                DataRow(cells: [
                  DataCell(Center(child: Text('Infección respiratoria en el último mes'))),
                  DataCell(Center(child: Text('No\nSi'))),
                  DataCell(Center(child: Text('0\n17'))),
                ]),
                DataRow(cells: [
                  DataCell(Center(child: Text('Anemia preoperatoria (< 10g/dL)'))),
                  DataCell(Center(child: Text('No\nSi'))),
                  DataCell(Center(child: Text('0\n11'))),
                ]),
                DataRow(cells: [
                  DataCell(Center(child: Text('Incisión quirúrgica'))),
                  DataCell(Center(child: Text('Periférica\nAbdomen superior\nTorácica'))),
                  DataCell(Center(child: Text('0\n15\n24'))),
                ]),
                DataRow(cells: [
                  DataCell(Center(child: Text('Duración de la cirugía'))),
                  DataCell(Center(child: Text('< 2horas\n2 a 3 horas\n>3 horas'))),
                  DataCell(Center(child: Text('0\n16\n23'))),
                ]),
                DataRow(cells: [
                  DataCell(Center(child: Text('Procedimiento de emergencia'))),
                  DataCell(Center(child: Text('No\nSi'))),
                  DataCell(Center(child: Text('0\n8'))),
                ]),
              ],
            ),
          ],
        );
      
  }
}



class StopBang extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const StopBang({Key? key, required this.onValueUpdated}) : super(key: key);

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
        Padding(
          padding: const EdgeInsets.all(8.0),
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
          columns: [
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
                        style: TextStyle(fontWeight: FontWeight.bold),
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
      widget.onValueUpdated('Escala De STOP-BANG: ','Alto Riesgo');
    } else {
      widget.onValueUpdated('Escala De STOP-BANG: ','Bajo Riesgo');
    }
  }
}




class ToracoScore extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const ToracoScore({Key? key, required this.onValueUpdated}) : super(key: key);

  @override
  State<ToracoScore> createState() => _ToracoScoreState();
}

class _ToracoScoreState extends State<ToracoScore> {
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Factor de riesgo')),
              DataColumn(label: Text('Opciones')),
              DataColumn(label: Text('Puntos')),
            ],
            rows: [
              _buildDataRow('Grupo de edad', '< 55 años', '0'),
              _buildDataRow('Grupo de edad', 'Entre 55 a 65 años', '1'),
              _buildDataRow('Grupo de edad', '> 65 años', '2'),
              _buildDataRow('Sexo', 'Femenino', '0'),
              _buildDataRow('Sexo', 'Masculino', '1'),
              _buildDataRow('Estado Físico', 'Estado funcional menor o igual a 2', '0'),
              _buildDataRow('Estado Físico', 'Actividad normal', '0'),
              _buildDataRow('Estado Físico', 'Síntomas, pero casi completamente ambulatorio', '0'),
              _buildDataRow('Estado Físico', 'Algún tiempo en la cama, pero menos de la mitad del día', '0'),
              _buildDataRow('Estado Físico', 'Estado funcional mayor o igual a 3', '1'),
              _buildDataRow('Estado Físico', 'Necesita encamamiento mayor del 50% del tiempo diario', '1'),
              _buildDataRow('Estado Físico', 'Imposible que pueda levantarse de la cama', '1'),
              _buildDataRow('Riesgo ASA', 'Menor o igual a 2', '0'),
              _buildDataRow('Riesgo ASA', 'Mayor o igual a 3', '1'),
              _buildDataRow('Puntuación disnea', 'Menor o igual a 2', '0'),
              _buildDataRow('Puntuación disnea', 'No disnea', '0'),
              _buildDataRow('Puntuación disnea', 'Disnea leve', '0'),
              _buildDataRow('Puntuación disnea', 'Disnea Moderada', '0'),
              _buildDataRow('Puntuación disnea', 'Disnea moderada a severa', '1'),
              _buildDataRow('Puntuación disnea', 'Disnea severa', '1'),
              _buildDataRow('Puntuación disnea', 'Disnea muy severa', '1'),
              _buildDataRow('Tipo de cirugía', 'Cirugía Electiva', '0'),
              _buildDataRow('Tipo de cirugía', 'Cirugía urgente o emergente', '1'),
              _buildDataRow('Tipo de intervención', 'Intervención: Neumectomía', '1'),
              _buildDataRow('Tipo de intervención', 'Si Intervención: Otras', '0'),
              _buildDataRow('Grupo de diagnóstico', 'Benigno', '0'),
              _buildDataRow('Grupo de diagnóstico', 'Maligno', '1'),
              _buildDataRow('Número de comorbilidades', 'Ninguna comorbilidad', '0'),
              _buildDataRow('Número de comorbilidades', 'Hasta 2 comorbilidades', '1'),
              _buildDataRow('Número de comorbilidades', '3 o más comorbilidades', '2'),
            ],
          ),
        ),
      ],
    );
  }

  DataRow _buildDataRow(String factor, String opciones, String puntos) {
    return DataRow(cells: [
      DataCell(Text(factor)),
      DataCell(Text(opciones)),
      DataCell(Text(puntos)),
    ]);
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
