import 'package:flutter/material.dart';
//ESTA ES LA CUARTA PÁGINA

class antecedentesPersonales extends StatefulWidget {
  const antecedentesPersonales({super.key});

  @override
  _AntecedentesPersonalesWidgetState createState() =>
      _AntecedentesPersonalesWidgetState();
}

class _AntecedentesPersonalesWidgetState extends State<antecedentesPersonales> {
  final List<String> _patologicosSeleccionados = [];
  String _quirurgicosSeleccionados = "";
  final List<String> _anestesicosSeleccionados = [];
  String _alergicosSeleccionados = "";
  String _toxicosSeleccionados = "";
  String _transfusionalesSeleccionados = "";
  final _quirurgicosController = TextEditingController();
  final _alergicosController = TextEditingController();

  final List<String> patologicos = [
    'Fumador.',
    'Bebedor social.',
    'Embarazo.',
    'Hipertensión gestacional controlada.',
    'Diabetes gestacional controlada.',
    'Obesidad grado I.',
    'Asma.',
    'Infección respiratoria aguda.',
    'Rinitis alérgica.',
    'Enfermedad cardiaca congénita asintomática.',
    'Epilepsia bien controlada.',
    'Síndrome de apnea del sueño leve o moderado.',
    'Cáncer en remisión.',
    'Autismo con limitaciones leves.',
    'Diabetes mellitus no insulinorequiriente.',
    'Hipertensión arterial controlada.',
    'Enfermedad renal crónica hasta etapa 4.',
    'Hipotiroidismo controlado.',
    'Paciente con COVID 19 asintomático.',
    'Preeclampsia moderada.',
    'Dependencia o abuso de alcohol.',
    'Diabetes gestacional con complicaciones o requerimiento de insulina.',
    'Eclampsia.',
    'Obesidad mórbida.',
    'Epilepsia no controlada.',
    'Síndrome de apnea del sueño severo.',
    'Cáncer activo o en tratamiento.',
    'Autismo con limitaciones severas.',
    'Enfermedad de Alzheimer.',
    'Enfermedad de Parkinson.',
    'Diabetes mellitus insulinorequiriente.',
    'Diabetes mellitus con afectación sistémica.',
    'Hipertensión arterial con afectación de órgano blanco.',
    'Enfermedad renal crónica etapa 5 en diálisis regular.',
    'Insuficiencia renal aguda.',
    'Daño hepático crónico hasta Child-Pugh B.',
    'Hepatitis aguda.',
    'Uso de marcapasos',
    'Disminución moderada de fracción de eyección cardiaca (40 a 50%).',
    'Distrofia muscular.',
    'Historia de trasplante de órgano.',
    'Malformación cerebral o espinal.',
    'Hidrocefalia.',
    'Malnutrición.',
    'Vía aérea difícil.',
    'Nutrición parenteral prolongada (se mantiene por más de 7 días).',
    'Enfermedad trombofílica.',
    'Hipotiroidismo no controlado.',
    'Accidente Isquémico Transitorio (De más de 3 meses del episodio).',
    'Infarto agudo de miocardio (De más de 3 meses del episodio).',
    'Endoprótesis vascular (STENT) De más de 3 meses del episodio.',
    'Paciente con COVID 19 sintomático.',
    'Síndrome de HELLP.',
    'Cardiomiopatía periparto con FEVI <40%.',
    'Embarazo asociado a enfermedad cardiaca no corregida.',
    'Cáncer avanzado, con metástasis.',
    'Enfermedad renal crónica etapa 5 din diálisis regular.',
    'Daño hepático crónico hasta Child-Pugh C.',
    'Disminución severa de fracción de eyección cardiaca (menor 40%).',
    'Accidente Isquémico Transitorio (De menos de 3 meses del episodio).',
    'Infarto Agudo al miocardio (De menos de 3 meses del episodio).',
    'Endoprótesis vascular (STENT) De menos de 3 meses del episodio.',
    'Shock.',
    'Sepsis.',
    'Coagulación intravascular diseminada.',
    'Síndrome de distrés respiratorio agudo.',
    'Insuficiencia cardiaca congestiva exacerbado.',
    'Desfibrilador cardioversor implantable (usuario).',
    'Dependencia de ventilación mecánica.',
    'Politraumatizado severo.',
    'Rotura uterina.',
    'Desprendimiento de placenta.',
    'Daño hepático crónico con encefalopatía hepática.',
    'Requerimiento de ECMO.',
    'Disfunción orgánica múltiple.',
    'Isquemia intestinal.',
    'Insuficiencia cardiaca congestiva descompensada.',
    'Con muerte cerebral: Donante de órganos.',
  ];

  final List<String> anestesicos = [
    'Sedación',
    'Anestesia general',
    'Anestesia raquídea',
    'Anestesia peridural',
    'Anestesia regional',
    'Anestesia local',
    // Agrega más opciones aquí
  ];
  String _filtroPatologicos = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antecedentes Personales'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ANTECEDENTES PERSONALES:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Antecedentes Patológicos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Buscar',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _filtroPatologicos = value.toLowerCase();
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildPatologicosList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Quirúrgicos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              value: "Si",
              groupValue: _quirurgicosSeleccionados,
              title: const Text('Si'),
              onChanged: (value) {
                setState(() {
                  _quirurgicosSeleccionados = value.toString();
                });
              },
            ),
            RadioListTile(
              value: "No",
              groupValue: _quirurgicosSeleccionados,
              title: const Text('No'),
              onChanged: (value) {
                setState(() {
                  _quirurgicosSeleccionados = value.toString();
                });
              },
            ),
            if (_quirurgicosSeleccionados == "Si")
              TextField(
                controller: _quirurgicosController,
                decoration: const InputDecoration(
                  labelText: 'Indique cuáles:',
                ),
                onChanged: (value) {
                  _quirurgicosSeleccionados = value;
                },
              ),
            const SizedBox(height: 32),
            const Text(
              'Anestésicos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              value: "Si",
              groupValue:
                  _anestesicosSeleccionados.contains("Si") ? "Si" : "No",
              title: const Text('Si'),
              onChanged: (value) {
                setState(() {
                  if (value == "Si") {
                    _anestesicosSeleccionados.add(value!);
                  } else {
                    _anestesicosSeleccionados.remove("Si");
                  }
                });
              },
            ),
            RadioListTile(
              value: "No",
              groupValue:
                  _anestesicosSeleccionados.contains("Si") ? "Si" : "No",
              title: const Text('No'),
              onChanged: (value) {
                setState(() {
                  if (value == "No") {
                    _anestesicosSeleccionados.remove("Si");
                  } else {
                    _anestesicosSeleccionados.add("Si");
                  }
                });
              },
            ),
            if (_anestesicosSeleccionados.contains("Si"))
              _buildAnestesicosList(),
            const SizedBox(height: 16),
            const Text(
              'Alergicos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              value: "Si",
              groupValue: _alergicosSeleccionados,
              title: const Text('Si'),
              onChanged: (value) {
                setState(() {
                  _alergicosSeleccionados = value.toString();
                });
              },
            ),
            RadioListTile(
              value: "No",
              groupValue: _alergicosSeleccionados,
              title: const Text('No'),
              onChanged: (value) {
                setState(() {
                  _alergicosSeleccionados = value.toString();
                });
              },
            ),
            if (_alergicosSeleccionados == "Si")
              TextField(
                controller: _alergicosController,
                decoration: const InputDecoration(
                  labelText: 'Indique cuáles:',
                ),
                onChanged: (value) {
                  _alergicosSeleccionados = value;
                },
              ),
            const SizedBox(height: 32),
            const Text(
              'Toxicos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              value: "Si",
              groupValue: _toxicosSeleccionados,
              title: const Text('Si'),
              onChanged: (value) {
                setState(() {
                  _toxicosSeleccionados = value.toString();
                });
              },
            ),
            RadioListTile(
              value: "No",
              groupValue: _toxicosSeleccionados,
              title: const Text('No'),
              onChanged: (value) {
                setState(() {
                  _toxicosSeleccionados = value.toString();
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Transfusionales:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              value: "Si",
              groupValue: _transfusionalesSeleccionados,
              title: const Text('Si'),
              onChanged: (value) {
                setState(() {
                  _transfusionalesSeleccionados = value.toString();
                });
              },
            ),
            RadioListTile(
              value: "No",
              groupValue: _transfusionalesSeleccionados,
              title: const Text('No'),
              onChanged: (value) {
                setState(() {
                  _transfusionalesSeleccionados = value.toString();
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                // ignore: avoid_print
                onPressed: () {
                  print('Patológicos: $_patologicosSeleccionados');
                  print('Quirúrgicos: $_quirurgicosSeleccionados');
                  print('Anestésicos: $_anestesicosSeleccionados');
                  print('Alergicos: $_alergicosSeleccionados');
                  print('Tóxicos: $_toxicosSeleccionados');
                  print('Transfusionales: $_transfusionalesSeleccionados');
                },
                child: const Text('Siguiente')),
          ],
        ),
      ),
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

  Widget _buildAnestesicosList() {
    return Column(
      children: anestesicos.map((anestesico) {
        return CheckboxListTile(
          title: Text(anestesico),
          value: _anestesicosSeleccionados.contains(anestesico),
          onChanged: (value) {
            setState(() {
              if (value != null && value) {
                _anestesicosSeleccionados.add(anestesico);
              } else {
                _anestesicosSeleccionados.remove(anestesico);
              }
            });
          },
        );
      }).toList(),
    );
  }
}
