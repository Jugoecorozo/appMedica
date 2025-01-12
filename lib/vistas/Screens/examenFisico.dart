import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/Escalas/escalaBelhouse.dart';
import 'package:app_medica/vistas/Escalas/escalaBrodsky.dart';
import 'package:app_medica/vistas/Escalas/escalaDeGlasgow.dart';
import 'package:app_medica/vistas/Escalas/escalaDeLangeron.dart';
import 'package:app_medica/vistas/Escalas/escalaInterincisivos.dart';
import 'package:app_medica/vistas/Escalas/escalaMallapati.dart';
import 'package:app_medica/vistas/Escalas/escalaPatilAldreti.dart';
import 'package:app_medica/vistas/Escalas/escalaProtrusionMandibular.dart';
import 'package:app_medica/vistas/Escalas/escalaSavva.dart';
import 'package:app_medica/vistas/Escalas/seccionEditableEF.dart';
import 'package:app_medica/vistas/Screens/planAnestesico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamenFisico extends StatefulWidget {
  const ExamenFisico({super.key});

  @override
  State<ExamenFisico> createState() => _ExamenFisicoState();
}

class _ExamenFisicoState extends State<ExamenFisico> {
  final TextEditingController _taController = TextEditingController();
  final TextEditingController _fcController = TextEditingController();
  final TextEditingController _frController = TextEditingController();
  final TextEditingController _satO2Controller = TextEditingController();

  Map<String, String> scaleValues = {};
  Map<String, String> editableSections = {
    'Cabeza y cuello': 'No facies dismórficas, pupilas isocóricas normoreactivas a la luz, apertura oral conservada, flexión y extensión de cuello conservada, distancia tiromentoniana conservada. NO predictores de vía aérea difícil',
    'Tórax': 'Simétrico, ruidos cardiacos rítmicos no soplos, murmullo vesicular conservado no estertores, sin alteraciones en dinámica ventilatoria',
    'Abdomen': 'Peristalsis presente, blando, depresible, no doloroso a la palpación superficial y profunda.',
    'Neurológico': 'No déficit, no focalizaciones, sin alteraciones cognoscitivas',
    'Extremidades': 'Simétricas, llenado capilar menor a 2 seg.',
  };

  void updateScaleValue(String scale, String value) {
    setState(() {
      scaleValues[scale] = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _taController.addListener(() {
      updateScaleValue('TA', '${_taController.text} mmHg');
    });
    _fcController.addListener(() {
      updateScaleValue('FC', '${_fcController.text} LPM');
    });
    _frController.addListener(() {
      updateScaleValue('FR', '${_frController.text} RPM');
    });
    _satO2Controller.addListener(() {
      updateScaleValue('SatO2', '${_satO2Controller.text} %');
    });
    editableSections.forEach((key, value) {
      scaleValues[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen Físico'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Signos Vitales',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildTextField('TA: __/__ mmHg', _taController),
            _buildTextField('FC: ____ LPM', _fcController),
            _buildTextField('FR: ____ RPM', _frController),
            _buildTextField('SatO2: ___ %', _satO2Controller),
            const SizedBox(height: 20),
            const Text(
              'Escalas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            EscalaGlasgow(updateScaleValue: updateScaleValue),
            const SizedBox(height: 20),
            EscalaLangeron(updateScaleValue: updateScaleValue),
            const SizedBox(height: 20),
            EscalaMallampati(updateScaleValue: updateScaleValue),
            const SizedBox(height: 20),
            EscalaPatilAldreti(updateScaleValue: updateScaleValue),
            const SizedBox(height: 20),
            EscalaSavva(updateScaleValue: updateScaleValue),
            const SizedBox(height: 20),
            EscalaInterincisivos(updateScaleValue: updateScaleValue),
            const SizedBox(height: 20),
            EscalaProtrusionMandibular(updateScaleValue: updateScaleValue),
            const SizedBox(height: 20),
            EscalaBellhouseDore(updateScaleValue: updateScaleValue),
            const SizedBox(height: 20),
            EscalaBrodsky(updateScaleValue: updateScaleValue),
            const SizedBox(height: 20),
            const Text(
              'Secciones Editables',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            ...editableSections.entries.map((entry) {
              return EditableSection(
                title: entry.key,
                initialText: entry.value,
                updateScaleValue: updateScaleValue,
              );
            }).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<datosFormulario>(context, listen: false).setExamenFisico(scaleValues);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const planAnestesico()));
              },
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taController.dispose();
    _fcController.dispose();
    _frController.dispose();
    _satO2Controller.dispose();
    super.dispose();
  }
}
