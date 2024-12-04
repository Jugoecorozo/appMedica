import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../calculos/datosFormulario.dart';

class ToracoScore extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const ToracoScore({Key? key, required this.onValueUpdated}) : super(key: key);

  @override
  State<ToracoScore> createState() => _ToracoScoreState();
}

class _ToracoScoreState extends State<ToracoScore> {
  String? _selectedAgeGroup;
  String? _selectedSex;
  String? _selectedPhysicalCondition;
  String? _selectedDyspneaScore;
  String? _selectedAsaRisk;
  String? _selectedSurgeryType;
  String? _selectedInterventionType;
  String? _selectedDiagnosticGroup;
  String? _selectedComorbiditiesNumber;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Escala De ToracoScore',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          _buildDropdown('Grupo de edad', ['< 55 años', 'Entre 55 a 65 años', '> 65 años'], (value) {
            setState(() {
              _selectedAgeGroup = value;
              _calculateTotalPoints();
            });
          }),
          _buildDropdown('Sexo', ['Femenino', 'Masculino'], (value) {
            setState(() {
              _selectedSex = value;
              _calculateTotalPoints();
            });
          }),
          _buildDropdown('Estado Físico', [
            'Actividad normal',
            'Síntomas, pero casi completamente ambulatorio',
            'Algún tiempo en la cama, pero menos de la mitad del día',
            'Necesita encamamiento mayor del 50% del tiempo diario',
            'Imposible que pueda levantarse de la cama',
          ], (value) {
            setState(() {
              _selectedPhysicalCondition = value;
              _calculateTotalPoints();
            });
          }),
          _buildDropdown('Riesgo ASA', ['Menor o igual a 2', 'Mayor o igual a 3'], (value) {
            setState(() {
              _selectedAsaRisk = value;
              _calculateTotalPoints();
            });
          }),
          _buildDropdown('Puntuación disnea', [
            'No disnea',
            'Disnea leve',
            'Disnea Moderada',
            'Disnea moderada a severa',
            'Disnea severa',
            'Disnea muy severa',
          ], (value) {
            setState(() {
              _selectedDyspneaScore = value;
              _calculateTotalPoints();
            });
          }),
          _buildDropdown('Tipo de cirugía', ['Cirugía Electiva', 'Cirugía urgente o emergente'], (value) {
            setState(() {
              _selectedSurgeryType = value;
              _calculateTotalPoints();
            });
          }),
          _buildDropdown('Tipo de intervención', ['Intervención: Neumectomía', 'Si Intervención: Otras'], (value) {
            setState(() {
              _selectedInterventionType = value;
              _calculateTotalPoints();
            });
          }),
          _buildDropdown('Grupo de diagnóstico', ['Benigno', 'Maligno'], (value) {
            setState(() {
              _selectedDiagnosticGroup = value;
              _calculateTotalPoints();
            });
          }),
          _buildDropdown('Número de comorbilidades', ['Ninguna comorbilidad', 'Hasta 2 comorbilidades', '3 o más comorbilidades'], (value) {
            setState(() {
              _selectedComorbiditiesNumber = value;
              _calculateTotalPoints();
            });
          }),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 10),
        DropdownButton<String>(
          isExpanded: true,
          hint: Text('Seleccione una opción'),
          value: label == 'Grupo de edad'
              ? _selectedAgeGroup
              : label == 'Sexo'
                  ? _selectedSex
                  : label == 'Estado Físico'
                      ? _selectedPhysicalCondition
                      : label == 'Riesgo ASA'
                          ? _selectedAsaRisk
                          : label == 'Puntuación disnea'
                              ? _selectedDyspneaScore
                              : label == 'Tipo de cirugía'
                                  ? _selectedSurgeryType
                                  : label == 'Tipo de intervención'
                                      ? _selectedInterventionType
                                      : label == 'Grupo de diagnóstico'
                                          ? _selectedDiagnosticGroup
                                          : label == 'Número de comorbilidades'
                                              ? _selectedComorbiditiesNumber
                                              : null,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            onChanged(value!);
          },
        ),
      ],
    );
  }

  int _calculateTotalPoints() {
    int totalPoints = 0;
    double totalCoefficient = 0.0;

    // Mapas para almacenar puntos y coeficientes
    final ageGroupPoints = {
      '< 55 años': 0,
      'Entre 55 a 65 años': 1,
      '> 65 años': 2,
    };

    final ageGroupCoefficients = {
      '< 55 años': 0.0,
      'Entre 55 a 65 años': 0.7679,
      '> 65 años': 1.0073,
    };

    final sexPoints = {
      'Femenino': 0,
      'Masculino': 1,
    };

    final sexCoefficients = {
      'Femenino': 0.0,
      'Masculino': 0.4505,
    };

    final physicalConditionValues = {
      'Actividad normal': 0,
      'Síntomas, pero casi completamente ambulatorio': 1,
      'Algún tiempo en la cama, pero menos de la mitad del día': 2,
      'Necesita encamamiento mayor del 50% del tiempo diario': 3,
      'Imposible que pueda levantarse de la cama': 4,
    };

    final asaRiskPoints = {
      'Menor o igual a 2': 0,
      'Mayor o igual a 3': 1,
    };

    final asaRiskCoefficients = {
      'Menor o igual a 2': 0.0,
      'Mayor o igual a 3': 0.6057,
    };

    final dyspneaScoreValues = {
      'No disnea': 0,
      'Disnea leve': 1,
      'Disnea Moderada': 2,
      'Disnea moderada a severa': 3,
      'Disnea severa': 4,
      'Disnea muy severa': 4,
    };

    final surgeryTypePoints = {
      'Cirugía Electiva': 0,
      'Cirugía urgente o emergente': 1,
    };

    final surgeryTypeCoefficients = {
      'Cirugía Electiva': 0.0,
      'Cirugía urgente o emergente': 0.8443,
    };

    final interventionTypePoints = {
      'Intervención: Neumectomía': 1,
      'Si Intervención: Otras': 0,
    };

    final interventionTypeCoefficients = {
      'Intervención: Neumectomía': 1.2176,
      'Si Intervención: Otras': 0.0,
    };

    final diagnosticGroupPoints = {
      'Benigno': 0,
      'Maligno': 1,
    };

    final diagnosticGroupCoefficients = {
      'Benigno': 0.0,
      'Maligno': 1.2423,
    };

    final comorbiditiesNumberPoints = {
      'Ninguna comorbilidad': 0,
      'Hasta 2 comorbilidades': 1,
      '3 o más comorbilidades': 2,
    };

    final comorbiditiesNumberCoefficients = {
      'Ninguna comorbilidad': 0.0,
      'Hasta 2 comorbilidades': 0.7447,
      '3 o más comorbilidades': 0.9064,
    };

    // Calcular puntos y coeficientes basados en el grupo de edad
    if (_selectedAgeGroup != null) {
      totalPoints += ageGroupPoints[_selectedAgeGroup] ?? 0;
      totalCoefficient += ageGroupCoefficients[_selectedAgeGroup] ?? 0.0;
    }

    // Calcular puntos y coeficientes basados en el sexo
    if (_selectedSex != null) {
      totalPoints += sexPoints[_selectedSex] ?? 0;
      totalCoefficient += sexCoefficients[_selectedSex] ?? 0.0;
    }

    // Calcular puntos y coeficientes basados en el estado físico
    if (_selectedPhysicalCondition != null) {
      int physicalConditionValue = physicalConditionValues[_selectedPhysicalCondition] ?? 0;
      if (physicalConditionValue >= 3) {
        totalPoints += 1;
        totalCoefficient += 0.689;
      } else {
        totalPoints += 0;
        totalCoefficient += 0.0;
      }
    }

    // Calcular puntos y coeficientes basados en la puntuación de disnea
    if (_selectedDyspneaScore != null) {
      int dyspneaScoreValue = dyspneaScoreValues[_selectedDyspneaScore] ?? 0;
      if (dyspneaScoreValue >= 3) {
        totalPoints += 1;
        totalCoefficient += 0.9075;
      } else {
        totalPoints += 0;
        totalCoefficient += 0.0;
      }
    }

    // Calcular puntos y coeficientes basados en el riesgo ASA
    if (_selectedAsaRisk != null) {
      totalPoints += asaRiskPoints[_selectedAsaRisk] ?? 0;
      totalCoefficient += asaRiskCoefficients[_selectedAsaRisk] ?? 0.0;
    }

    // Calcular puntos y coeficientes basados en el tipo de cirugía
    if (_selectedSurgeryType != null) {
      totalPoints += surgeryTypePoints[_selectedSurgeryType] ?? 0;
      totalCoefficient += surgeryTypeCoefficients[_selectedSurgeryType] ?? 0.0;
    }

    // Calcular puntos y coeficientes basados en el tipo de intervención
    if (_selectedInterventionType != null) {
      totalPoints += interventionTypePoints[_selectedInterventionType] ?? 0;
      totalCoefficient += interventionTypeCoefficients[_selectedInterventionType] ?? 0.0;
    }

    // Calcular puntos y coeficientes basados en el grupo de diagnóstico
    if (_selectedDiagnosticGroup != null) {
      totalPoints += diagnosticGroupPoints[_selectedDiagnosticGroup] ?? 0;
      totalCoefficient += diagnosticGroupCoefficients[_selectedDiagnosticGroup] ?? 0.0;
    }

    // Calcular puntos y coeficientes basados en el número de comorbilidades
    if (_selectedComorbiditiesNumber != null) {
      totalPoints += comorbiditiesNumberPoints[_selectedComorbiditiesNumber] ?? 0;
      totalCoefficient += comorbiditiesNumberCoefficients[_selectedComorbiditiesNumber] ?? 0.0;
    }

    Provider.of<datosFormulario>(context, listen: false).updateProbMuerteHospitalaria(totalCoefficient);
    Provider.of<datosFormulario>(context, listen: false).updateASA(totalPoints);

    widget.onValueUpdated('Escala de ToracoScore', '$totalPoints puntos');

    return totalPoints;
  }
}