import 'package:flutter/material.dart';

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
  String? _selectedAsaRisk;
  String? _selectedDyspneaScore;
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
            });
          }),
          _buildDropdown('Sexo', ['Femenino', 'Masculino'], (value) {
            setState(() {
              _selectedSex = value;
            });
          }),
          _buildDropdown('Estado Físico', [
            'Estado funcional menor o igual a 2',
            'Actividad normal',
            'Síntomas, pero casi completamente ambulatorio',
            'Algún tiempo en la cama, pero menos de la mitad del día',
            'Estado funcional mayor o igual a 3',
            'Necesita encamamiento mayor del 50% del tiempo diario',
            'Imposible que pueda levantarse de la cama',
          ], (value) {
            setState(() {
              _selectedPhysicalCondition = value;
            });
          }),
          _buildDropdown('Riesgo ASA', ['Menor o igual a 2', 'Mayor o igual a 3'], (value) {
            setState(() {
              _selectedAsaRisk = value;
            });
          }),
          _buildDropdown('Puntuación disnea', [
            'Menor o igual a 2',
            'No disnea',
            'Disnea leve',
            'Disnea Moderada',
            'Disnea moderada a severa',
            'Disnea severa',
            'Disnea muy severa',
          ], (value) {
            setState(() {
              _selectedDyspneaScore = value;
            });
          }),
          _buildDropdown('Tipo de cirugía', ['Cirugía Electiva', 'Cirugía urgente o emergente'], (value) {
            setState(() {
              _selectedSurgeryType = value;
            });
          }),
          _buildDropdown('Tipo de intervención', ['Intervención: Neumectomía', 'Si Intervención: Otras'], (value) {
            setState(() {
              _selectedInterventionType = value;
            });
          }),
          _buildDropdown('Grupo de diagnóstico', ['Benigno', 'Maligno'], (value) {
            setState(() {
              _selectedDiagnosticGroup = value;
            });
          }),
          _buildDropdown('Número de comorbilidades', ['Ninguna comorbilidad', 'Hasta 2 comorbilidades', '3 o más comorbilidades'], (value) {
            setState(() {
              _selectedComorbiditiesNumber = value;
            });
          }),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Calcula la puntuación total aquí usando los valores seleccionados
              String totalPoints = _calculateTotalPoints().toString();
              widget.onValueUpdated('Escala de ToracoScore', '$totalPoints puntos');
            },
            child: Text('Calcular'),
          ),
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
    // Calcula la puntuación total basada en los valores seleccionados
    int totalPoints = 0;
    // Añade aquí la lógica para calcular la puntuación total
    return totalPoints;
  }
}