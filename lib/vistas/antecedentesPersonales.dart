import 'dart:math';

import 'package:flutter/material.dart';

class antecedentesPersonales extends StatefulWidget {
  @override
  _AntecedentesPersonalesWidgetState createState() =>
      _AntecedentesPersonalesWidgetState();
}

class _AntecedentesPersonalesWidgetState extends State<antecedentesPersonales> {
  List<String> _patologicosSeleccionados = [];
  String _quirurgicosSeleccionados = '';
  String _anestesicosSeleccionados = '';
  String _alergicosSeleccionados = '';
  String _toxicosSeleccionados = '';
  String _transfusionalesSeleccionados = '';

final List<String> patologicos = [
    'Fumador',
    'Bebedor social',
    'Embarazo',
    // Agrega más opciones aquí
  ];
  String _filtroPatologicos = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Antecedentes Personales'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ANTECEDENTES PERSONALES:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
             Text(
              'Antecedentes Patológicos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Buscar',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _filtroPatologicos = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 8),
            _buildPatologicosList(),
            SizedBox(height: 16),
            Text(
              'Quirúrgicos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildRadioList([
              'Si',
              'No',
            ], (value) {
              setState(() {
                _quirurgicosSeleccionados = value;
              });
            }),
            SizedBox(height: 16),
            if (_quirurgicosSeleccionados == 'Si') ...[
              // Aquí puedes agregar los campos adicionales para el caso de 'Si'
              // Por ejemplo, un TextFormField para escribir detalles
              TextFormField(
                decoration: InputDecoration(labelText: 'Detalles quirúrgicos'),
              ),
            ],
            SizedBox(height: 16),
            Text(
              'Anestésicos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildRadioList([
              'Si',
              'No',
            ], (value) {
              setState(() {
                _anestesicosSeleccionados = value;
              });
            }),
            SizedBox(height: 16),
            if (_anestesicosSeleccionados == 'Si') ...[
              // Aquí puedes agregar los campos adicionales para el caso de 'Si'
              // Por ejemplo, un DropdownButtonFormField para seleccionar el tipo de anestesia
              DropdownButtonFormField(
                items: [
                  'Sedación',
                  'Anestesia general',
                  'Anestesia raquídea',
                  'Anestesia peridural',
                  'Anestesia regional',
                  'Anestesia local'
                ]
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  // Manejar la selección del tipo de anestesia aquí
                },
              ),
              // Y otros campos adicionales según sea necesario
            ],
            SizedBox(height: 16),
            Text(
              'Alérgicos:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _alergicosSeleccionados == 'Si' ? Colors.red : null),
            ),
            _buildRadioList([
              'Si',
              'No',
            ], (value) {
              setState(() {
                _alergicosSeleccionados = value;
              });
            }),
            SizedBox(height: 16),
            if (_alergicosSeleccionados == 'Si') ...[
              // Aquí puedes agregar los campos adicionales para el caso de 'Si'
              // Por ejemplo, un TextFormField para escribir detalles de las alergias
              TextFormField(
                decoration: InputDecoration(labelText: 'Detalles de alergias'),
              ),
            ],
            SizedBox(height: 16),
            Text(
              'Tóxicos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildRadioList([
              'Si',
              'No',
            ], (value) {
              setState(() {
                _toxicosSeleccionados = value;
              });
            }),
            SizedBox(height: 16),
            if (_toxicosSeleccionados == 'Si') ...[
              // Aquí puedes agregar los campos adicionales para el caso de 'Si'
              // Por ejemplo, CheckBoxes para seleccionar los tipos de tóxicos
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tipos de tóxicos:'),
                  CheckboxListTile(
                    title: Text('Tabaquismo'),
                    value: false,
                    onChanged: (value) {
                      // Manejar la selección del tóxico aquí
                    },
                  ),
                  // Agregar más CheckBoxes según sea necesario
                ],
              ),
              // Y otros campos adicionales según sea necesario
            ],
            SizedBox(height: 16),
            Text(
              'Transfusionales:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildRadioList([
              'Si',
              'No',
            ], (value) {
              setState(() {
                _transfusionalesSeleccionados = value;
              });
            }),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckBoxList(List<String> options, Function(String) onChanged) {
    return Column(
      children: options.map((option) {
        return CheckboxListTile(
          title: Text(option),
          value: _patologicosSeleccionados == option,
          onChanged: (value) {
            onChanged(option);
          },
        );
      }).toList(),
    );
  }

  Widget _buildRadioList(List<String> options, Function(String) onChanged) {
    return Column(
      children: options.map((option) {
        return RadioListTile(
          title: Text(option),
          value: option,
          groupValue: option,
          onChanged: (value) {
            onChanged(option);
          },
        );
      }).toList(),
    );
  }

  Widget _buildPatologicosList() {
    final List<String> patologicosFiltrados = patologicos.where((patologico) {
      return patologico.toLowerCase().contains(_filtroPatologicos);
    }).toList();

    return Column(
      children: patologicosFiltrados.map((patologico) {
        return CheckboxListTile(
          title: Text(patologico),
          value: _patologicosSeleccionados.contains(patologico),
          onChanged: (value) {
            setState(() {
              if (value != null && value) {
                _patologicosSeleccionados.add(patologico);
              } else {
                _patologicosSeleccionados.remove(patologico);
              }
            });
          },
        );
      }).toList(),
    );
  }
}

