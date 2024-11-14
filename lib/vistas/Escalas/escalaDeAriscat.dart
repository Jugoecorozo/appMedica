import 'package:flutter/material.dart';

class Ariscat extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Ariscat({super.key, required this.onValueUpdated});

  @override
  State<Ariscat> createState() => _AriscatState();
}

class _AriscatState extends State<Ariscat> {
  Map<String, int?> riskPoints = {
    'Edad, años': null,
    'Saturación parcial de oxígeno preoperatorio': null,
    'Infección respiratoria en el último mes': null,
    'Anemia preoperatoria (< 10g/dL)': null,
    'Incisión quirúrgica': null,
    'Duración de la cirugía': null,
    'Procedimiento de emergencia': null,
  };

  final List<String> ageOptions = ['<50', '51-80', '>80'];
  final List<String> spoOptions = ['>96%', '91-95%', '<90%'];
  final List<String> respiratoryInfectionOptions = ['No', 'Sí'];
  final List<String> preoperativeAnemiaOptions = ['No', 'Sí'];
  final List<String> surgicalIncisionOptions = ['Periférica', 'Abdomen superior', 'Torácica'];
  final List<String> surgeryDurationOptions = ['< 2 horas', '2 a 3 horas', '> 3 horas'];
  final List<String> emergencyProcedureOptions = ['No', 'Sí'];

  void _updatePoints(String riskFactor, String option) {
    setState(() {
      switch (riskFactor) {
        case 'Edad, años':
          riskPoints[riskFactor] = ageOptions.indexOf(option) * 2;
          break;
        case 'Saturación parcial de oxígeno preoperatorio':
          riskPoints[riskFactor] = spoOptions.indexOf(option) * 8;
          break;
        case 'Infección respiratoria en el último mes':
          riskPoints[riskFactor] = respiratoryInfectionOptions.indexOf(option) * 17;
          break;
        case 'Anemia preoperatoria (< 10g/dL)':
          riskPoints[riskFactor] = preoperativeAnemiaOptions.indexOf(option) * 11;
          break;
        case 'Incisión quirúrgica':
          riskPoints[riskFactor] = surgicalIncisionOptions.indexOf(option) * 15;
          break;
        case 'Duración de la cirugía':
          riskPoints[riskFactor] = surgeryDurationOptions.indexOf(option) * 16;
          break;
        case 'Procedimiento de emergencia':
          riskPoints[riskFactor] = emergencyProcedureOptions.indexOf(option) * 8;
          break;
        default:
          break;
      }
    });

    int totalPoints = 0;
    for (var points in riskPoints.values) {
      if (points != null) {
        totalPoints += points;
      }
    }
     String riskCategory = _calculateRiskCategory(totalPoints);
    double complicationRisk = _calculateComplicationRisk(totalPoints);

    widget.onValueUpdated(
        "ESCALA DE ARISCAT",
        "$totalPoints puntos, riesgo $riskCategory (${complicationRisk.toStringAsFixed(1)}%) para presentar complicaciones pulmonares postoperatorias.");
 
  }

  String _calculateRiskCategory(int totalPoints) {
    if (totalPoints < 26) {
      return "bajo";
    } else if (totalPoints <= 44) {
      return "intermedio";
    } else {
      return "alto";
    }
  }

  double _calculateComplicationRisk(int totalPoints) {
    if (totalPoints < 26) {
      return 1.6;
    } else if (totalPoints <= 44) {
      return 13.3;
    } else {
      return 42.1;
    }
  }

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
        for (var riskFactor in riskPoints.keys)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(riskFactor),
              DropdownButton<String>(
                isExpanded: true,
                hint: const Text('Seleccione una opción'),
                value: riskPoints[riskFactor] == null
                    ? null
                    : (() {
                        switch (riskFactor) {
                          case 'Edad, años':
                            return ageOptions[riskPoints[riskFactor]! ~/ 2];
                          case 'Saturación parcial de oxígeno preoperatorio':
                            return spoOptions[riskPoints[riskFactor]! ~/ 8];
                          case 'Infección respiratoria en el último mes':
                            return respiratoryInfectionOptions[riskPoints[riskFactor]! ~/ 17];
                          case 'Anemia preoperatoria (< 10g/dL)':
                            return preoperativeAnemiaOptions[riskPoints[riskFactor]! ~/ 11];
                          case 'Incisión quirúrgica':
                            return surgicalIncisionOptions[riskPoints[riskFactor]! ~/ 15];
                          case 'Duración de la cirugía':
                            return surgeryDurationOptions[riskPoints[riskFactor]! ~/ 16];
                          case 'Procedimiento de emergencia':
                            return emergencyProcedureOptions[riskPoints[riskFactor]! ~/ 8];
                          default:
                            return null;
                        }
                      })(),
                items: (() {
                  switch (riskFactor) {
                    case 'Edad, años':
                      return ageOptions;
                    case 'Saturación parcial de oxígeno preoperatorio':
                      return spoOptions;
                    case 'Infección respiratoria en el último mes':
                      return respiratoryInfectionOptions;
                    case 'Anemia preoperatoria (< 10g/dL)':
                      return preoperativeAnemiaOptions;
                    case 'Incisión quirúrgica':
                      return surgicalIncisionOptions;
                    case 'Duración de la cirugía':
                      return surgeryDurationOptions;
                    case 'Procedimiento de emergencia':
                      return emergencyProcedureOptions;
                    default:
                      return <String>[];
                  }
                })().map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  _updatePoints(riskFactor, newValue!);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
      ],
    );
  }
}