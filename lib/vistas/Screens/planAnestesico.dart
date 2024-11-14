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

  final List<String> options = [
    'Programar para procedimiento quirúrgico.',
    'Ayuno de 8 horas.',
    'Administrar antihipertensivos el día del procedimiento quirúrgico con muy poca agua.',
    'Administrar insulina la mitad de la dosis en la noche previa al procedimiento. El día del procedimiento no administrar.',
    'Reservar 2 Unidades de GRE.',
    'Reservar Unidad de Cuidados Intensivos.',
    'Reservar Unidad de Cuidados Intermedios.',
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
      }
    });
  }

  Future<void> _onSaveButtonPressed() async {
    Provider.of<datosFormulario>(context, listen: false)
        .setSelectedOptions(selectedOptions);
    Provider.of<datosFormulario>(context, listen: false).setFreeText(_freeTextController.text);

    final data = Provider.of<datosFormulario>(context, listen: false);
    final pdfFile = await resultados.generarDocumento(data);
    OpenFile.open(pdfFile.path);
    // Aquí puedes realizar cualquier acción que desees con la lista de opciones seleccionadas
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
            return CheckboxListTile(
              title: Text(option),
              value: selectedOptions.contains(option),
              onChanged: (bool? value) {
                _onOptionSelected(option, value);
              },
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
