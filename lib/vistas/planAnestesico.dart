import 'package:flutter/material.dart';


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

  void _onOptionSelected(String option, bool? value) {
    setState(() {
      if (value ?? false) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
      }
    });
  }

  void _onSaveButtonPressed() {
    print(selectedOptions);
    // Aquí puedes realizar cualquier acción que desees con la lista de opciones seleccionadas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Anestésico'),
      ),
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return CheckboxListTile(
            title: Text(option),
            value: selectedOptions.contains(option),
            onChanged: (bool? value) {
              _onOptionSelected(option, value);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSaveButtonPressed,
        child: const Icon(Icons.save),
      ),
    );
  }
}