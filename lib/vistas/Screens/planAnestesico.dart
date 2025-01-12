import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/Screens/resultados.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class planAnestesico extends StatefulWidget {
  const planAnestesico({super.key});

  @override
  State<planAnestesico> createState() => _planAnestesicoState();
}

class _planAnestesicoState extends State<planAnestesico> {
  List<String> selectedOptions = [];
  Map<String, int> unitSelections = {};

  final List<String> options = [
    'Programar para procedimiento quirúrgico.',
    'Posible vía aérea difícil, se recomienda kit de vía aérea difícil.',
    'Se recomienda intubación con fibrolaringoscopio.',
    'Se recomienda intubación con videolaringoscopio.',
    'Ayuno de 8 horas para alimentos sólidos.',
    'Ayuno de 4 horas para no claros (Lácteos, fórmula láctea, líquidos con partículas en suspensión, sustancias alcohólicas, contrastes radiológicos orales).',
    'Ayuno de 2 horas para líquidos claros (Agua, zumo sin pulpa, café o té).',
    'Se recomienda monitoreo invasivo.',
    'Reservar Unidades de GRE',
    'Reservar Unidades de Plasma',
    'Reservar Unidades de Crioprecipitados',
    'Transfundir Unidades de GRE',
    'Transfundir Unidades de Plasma',
    'Transfundir Unidades de Crioprecipitados',
    'Reservar Unidad de Cuidados Intensivos.',
    'Reservar Unidad de Cuidados Intermedios.',
    'Administrar antihipertensivos el día del procedimiento quirúrgico con muy poca agua.',
    'Administrar la mitad de la dosis de insulina en la noche previa al procedimiento. El día del procedimiento no administrar.',
    'Administrar anticonvulsivantes en su horario habitual.',
    'Suspender heparina 12 horas previo al procedimiento.',
    'Colocar imán sobre el marcapaso durante el procedimiento para evitar interferencias y si se requiere electrocauterio que sea bipolar y aplicar ráfagas cortas menores a 5 segundos.',
    'Se recomienda el uso de electrocauterio bipolar, con descargas cortas (<5 seg), con la menor amplitud posible y manteniendo el lápiz de electrocauterización alejado del dispositivo (>15 cm).',
    'En caso de electrocoagulación monopolar, la unidad electroquirúgica debe conectarse de tal manera que el circuito eléctrico se mantenga alejado del dispositivo cardiaco y sus electrodos.',
    'Se debe configurar el dispositivo de estimulación cardiaca en modo asincrónico.',
    'Tras la cirugía se debe revisar y si es necesario reprogramar el dispositivo de estimulación cardiaca lo antes posible.',
    'Tener acompañante mayor de edad el día del procedimiento.',
    'Firmar consentimiento informado.',
    'Se explica técnica anestésica y sus posibles complicaciones, quien refiere entender y aceptar.',
  ];

  final TextEditingController _freeTextController = TextEditingController();

  void _onOptionSelected(String option, bool? value) {
    setState(() {
      if (value ?? false) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
        unitSelections.remove(option);
      }
    });
  }

  void _onUnitSelected(String option, int? value) {
    setState(() {
      if (value != null) {
        unitSelections[option] = value;
      }
    });
  }

  Future<void> _onSaveButtonPressed() async {
    final freeText = _freeTextController.text;
    final freeTextLines = freeText.split('\n').where((line) => line.trim().isNotEmpty).toList();

    // Clear previously added free text lines to avoid duplication
    selectedOptions.removeWhere((option) => !options.contains(option));
    selectedOptions.addAll(freeTextLines);

    // Concatenate unit selections with options
    final concatenatedOptions = selectedOptions.map((option) {
      if (unitSelections.containsKey(option)) {
        return '$option (${unitSelections[option]} unidades)';
      }
      return option;
    }).toList();

    Provider.of<datosFormulario>(context, listen: false)
        .setSelectedOptions(concatenatedOptions);
    Provider.of<datosFormulario>(context, listen: false).setFreeText(freeText);

    final data = Provider.of<datosFormulario>(context, listen: false);
    final pdfFile = await resultados.generarDocumento(data);
    OpenFile.open(pdfFile.path);
    // Aquí puedes realizar cualquier acción que desees con la lista de opciones seleccionadas
  }

  void _onFreeTextChanged() {
    setState(() {
      final freeText = _freeTextController.text;
      final freeTextLines = freeText.split('\n').where((line) => line.trim().isNotEmpty).toList();

      // Clear previously added free text lines to avoid duplication
      selectedOptions.removeWhere((option) => !options.contains(option));
      selectedOptions.addAll(freeTextLines);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Anestésico'),
      ),
      body: ListView.builder(
        itemCount: options.length + 1, // +1 para el TextField adicional
        itemBuilder: (context, index) {
          if (index < options.length) {
            final option = options[index];
            return Column(
              children: [
                CheckboxListTile(
                  title: Text(option),
                  value: selectedOptions.contains(option),
                  onChanged: (bool? value) {
                    _onOptionSelected(option, value);
                  },
                ),
                if (selectedOptions.contains(option) && option.contains('Unidades')) 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<int>(
                      hint: const Text('Seleccionar número de unidades'),
                      value: unitSelections[option],
                      items: List.generate(10, (i) => i + 1)
                          .map((e) => DropdownMenuItem<int>(
                                value: e,
                                child: Text(e.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _onUnitSelected(option, value);
                      },
                    ),
                  ),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _freeTextController,
                decoration: const InputDecoration(
                  labelText: 'Escribe aquí cualquier otra información',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                onChanged: (text) => _onFreeTextChanged(),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSaveButtonPressed,
        child: const Icon(Icons.save),
      ),
    );
  }
}
