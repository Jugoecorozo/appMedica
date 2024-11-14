import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/Escalas/EuroScoreII.dart';
import 'package:app_medica/vistas/Escalas/capacidadFuncional.dart';
import 'package:app_medica/vistas/Escalas/escalaDeApfel.dart';
import 'package:app_medica/vistas/Escalas/escalaDeAriscat.dart';
import 'package:app_medica/vistas/Escalas/escalaDeBarthel.dart';
import 'package:app_medica/vistas/Escalas/escalaDeCaprini.dart';
import 'package:app_medica/vistas/Escalas/escalaDeGlance.dart';
import 'package:app_medica/vistas/Escalas/escalaDeLee.dart';
import 'package:app_medica/vistas/Escalas/stopBang.dart';
import 'package:app_medica/vistas/Escalas/toracoScore.dart';
import 'package:app_medica/vistas/Screens/antecedentesPersonales.dart';
import 'package:app_medica/vistas/Screens/examenFisico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class SurgeryRiskCalculator extends StatefulWidget {


  const SurgeryRiskCalculator({
    super.key,
  });

  @override
  _SurgeryRiskCalculatorState createState() => _SurgeryRiskCalculatorState();
}

class _SurgeryRiskCalculatorState extends State<SurgeryRiskCalculator> {

  @override
  initState() {

    super.initState();
  }
  
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
    var patientAge = Provider.of<datosFormulario>(context, listen: false).edad;
    var patientIMC = Provider.of<datosFormulario>(context, listen: false).imc;
    print(patientAge);
    print(patientIMC);
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
                isExpanded: true,
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
                    scaleWidget =
                        GlanceScaleWidget(onValueUpdated: updateScaleValue);
                       const SizedBox(height: 20);
                  } else if (scale ==
                      'Escala De Índice Revisado De Riesgo Cardíaco Modificado (LEE)') {
                    scaleWidget =
                        LeeScaleWidget(onValueUpdated: updateScaleValue);
                        const SizedBox(height: 20);
                  } else if (scale == 'Escala De Capacidad Funcional') {
                    scaleWidget =
                        CapacidadFuncional(onValueUpdated: updateScaleValue);
                        const SizedBox(height: 20);
                  } else if (scale ==
                      'Escala Caprini Para Riesgo De Trombosis Venosa') {
                    scaleWidget = Caprini(onValueUpdated: updateScaleValue);
                    const SizedBox(height: 20);
                  } else if (scale == 'Escala De APFEL') {
                    scaleWidget = Apfel(onValueUpdated: updateScaleValue);
                    const SizedBox(height: 20);
                  } else if (scale == 'Escala ARISCAT') {
                    scaleWidget = Ariscat(onValueUpdated: updateScaleValue);
                    const SizedBox(height: 20);
                  } else if (scale == 'EUROSCORE II') {
                    scaleWidget = EuroScoreIIScreen(onValueUpdated: updateScaleValue);
                    const SizedBox(height: 20);
                  } else if (scale == 'TORACOSCORE') {
                    scaleWidget = ToracoScore(onValueUpdated: updateScaleValue);
                    const SizedBox(height: 20);
                  } else {
                    scaleWidget = const SizedBox();
                  }

                  // Agregar STOP BANG si el IMC es mayor o igual a 30
                  if (scale == 'Escala De Barthel' && patientAge > 65) {
                  scaleWidget = BarthelForm(onValueUpdated: updateScaleValue);

                  } else if (scale == 'Escala De STOP-BANG' && patientIMC >= 30) {
                  scaleWidget = StopBang(onValueUpdated: updateScaleValue);
                  }

                  // Retornar el widget de la escala actual
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: scaleWidget,
                  );
                }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Provider.of<datosFormulario>(context, listen: false)
                      .setSelectedSurgery(selectedSurgery);
                  Provider.of<datosFormulario>(context, listen: false)
                      .setScaleValues(scaleValues);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ExamenFisico()));
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