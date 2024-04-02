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
  final List<String> _quirurgicosSeleccionados = [];
  final List<String> _anestesicosSeleccionados = [];
  final List<String> _alergicosSeleccionados = [];
  final List<String> _toxicosSeleccionados = [];
  final List<String> _transfusionalesSeleccionados = [];

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

  final List<String> quirurgicos = [
    'Sí',
    'No',
    // Agrega más opciones aquí...
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

  final List<String> complicacionesAnestesicas = [
    'Apnea',
    'Dificultad para la ventilación',
    'Dificultad para la intubación',
    'Cefalea postpunción',
    'Nausea y vómito',
    'Infección del sitio de punción',
    'Dolor persistente en el sitio de punción',
    'Neuroinfección',
    'Ulcera corneal',
    'Epistaxis',
    'Irritabilidad postanestésica',
    'Despertar intraoperatorio',
    'Parestesia',
    'Neuropatía',
    'Otros'
  ];

  final List<String> alergicos = [
    'Sí',
    'No',
    // Agrega más opciones aquí...
  ];

  final List<String> toxicos = [
    'No tiene antecedentes Tóxicos',
    'Tabaquismo',
    'Sustancias psicoactivas',
    'Alcoholismo',
    'Biomasa',
    'Otros',
  ];

  final List<String> transfusionales = [
    'Sí',
    'No',
    // Agrega más opciones aquí...
  ];

  final List<String> _complicacionesAnestesicasSeleccionadas = [];
  String _quirurgicosEspecifica = '';
  String _transfusionalesEspecifica = '';
  String _alergicosEspecifica = '';
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
            _buildTitle(),
            SizedBox(height: 16),
            _buildPatologicosSection(),
            SizedBox(height: 16),
            _buildQuirurgicosSection(),
            SizedBox(height: 16),
            _buildAnestesicosSection(),
            SizedBox(height: 16),
            _buildAlergicosSection(),
            SizedBox(height: 16),
            _buildToxicosSection(),
            SizedBox(height: 16),
            _buildTransfusionalesSection(),
            SizedBox(height: 16),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'ANTECEDENTES PERSONALES:',
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildPatologicosSection() {
    return _buildListSection(
      title: 'Antecedentes Patológicos:',
      options: patologicos,
      selectedOptions: _patologicosSeleccionados,
    );
  }

  Widget _buildQuirurgicosSection() {
    return _buildListSection(
    title: 'Antecedentes Quirúrgicos:',
    options: quirurgicos,
    selectedOptions: _quirurgicosSeleccionados,
    isSingleSelection: true,
    onEspecificaChanged: (value) {
      setState(() {
        _quirurgicosEspecifica = value;
        if (!_quirurgicosSeleccionados.contains(value)) {
          _quirurgicosSeleccionados.add(value);
        }
      });
    },
  );
  }

  Widget _buildAnestesicosSection() {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildListSection(
        title: 'Antecedentes Anestésicos:',
        options: anestesicos,
        selectedOptions: _anestesicosSeleccionados,
        isSingleSelection: true,
      ),
      SizedBox(height: 16),
      _buildListSection(
        title: 'Complicaciones Anestésicas:',
        options: complicacionesAnestesicas,
        selectedOptions: _complicacionesAnestesicasSeleccionadas,
      ),
    ],
  );
  }

  Widget _buildAlergicosSection() {
    return _buildListSection(
    title: 'Antecedentes Alérgicos:',
    options: alergicos,
    selectedOptions: _alergicosSeleccionados,
    isSingleSelection: true,
    onEspecificaChanged: (value) {
      setState(() {
        _alergicosEspecifica = value;
        if (!_alergicosSeleccionados.contains(value)) {
          _alergicosSeleccionados.add(value);
        }
      });
    },
  );
  }

  Widget _buildToxicosSection() {
    return _buildListSection(
      title: 'Antecedentes Tóxicos:',
      options: toxicos,
      selectedOptions: _toxicosSeleccionados,
      isSingleSelection: true
    );
  }

  Widget _buildTransfusionalesSection() {
    return _buildListSection(
    title: 'Antecedentes Transfusionales:',
    options: transfusionales,
    selectedOptions: _transfusionalesSeleccionados,
    isSingleSelection: true,
    onEspecificaChanged: (value) {
      setState(() {
        _transfusionalesEspecifica = value;
        if (!_transfusionalesSeleccionados.contains(value)) {
          _transfusionalesSeleccionados.add(value);
        }
      });
    },
  );
  }

Widget _buildListSection({
    required String title,
    required List<String> options,
    required List<String> selectedOptions,
    bool isSingleSelection = false,
    Function(String)? onEspecificaChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!isSingleSelection)
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
                if (!isSingleSelection) const SizedBox(height: 8),
                _buildList(options, selectedOptions, isSingleSelection, onEspecificaChanged),
              ],
            ),
          ),
        ),
      ],
    );
  }

Widget _buildList(List<String> options, List<String> selectedOptions, bool isSingleSelection, Function(String)? onEspecificaChanged) {
  final List<String> filteredOptions = options.where((option) {
    return option.toLowerCase().contains(_filtroPatologicos);
  }).toList();
  return Column(
    children: [
      ...filteredOptions.map((option) {
        return CheckboxListTile(
          title: Text(option),
          value: selectedOptions.contains(option),
          onChanged: (value) {
            setState(() {
              if (value != null && value) {
                if (isSingleSelection) {
                  selectedOptions.clear();
                }
                selectedOptions.add(option);
              } else {
                selectedOptions.remove(option);
              }
            });
          },
        );
      }).toList(),
      if (isSingleSelection && selectedOptions.contains('Sí'))
        TextField(
          decoration: InputDecoration(
            labelText: 'Por favor, especifica',
          ),
          onChanged: onEspecificaChanged,
        ),
    ],
  );
}

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        print('Patológicos: $_patologicosSeleccionados');
        print('Quirúrgicos: $_quirurgicosSeleccionados');
        print('Anestésicos: $_anestesicosSeleccionados');
        print('Alergicos: $_alergicosSeleccionados');
        print('Tóxicos: $_toxicosSeleccionados');
        print('Transfusionales: $_transfusionalesSeleccionados');
      },
      child: const Text('Siguiente'),
    );
  }
}
/*

final TextEditingController _quirurgicosController = TextEditingController();
final TextEditingController _transfusionalesController = TextEditingController();
final TextEditingController _alergicosController = TextEditingController();

Widget _buildQuirurgicosSection() {
  return _buildListSection(
    title: 'Antecedentes Quirúrgicos:',
    options: quirurgicos,
    selectedOptions: _quirurgicosSeleccionados,
    isSingleSelection: true,
    textFieldController: _quirurgicosController,
  );
}

Widget _buildTransfusionalesSection() {
  return _buildListSection(
    title: 'Antecedentes Transfusionales:',
    options: transfusionales,
    selectedOptions: _transfusionalesSeleccionados,
    isSingleSelection: true,
    textFieldController: _transfusionalesController,
  );
}

Widget _buildAlergicosSection() {
  return _buildListSection(
    title: 'Antecedentes Alérgicos:',
    options: alergicos,
    selectedOptions: _alergicosSeleccionados,
    isSingleSelection: true,
    textFieldController: _alergicosController,
  );
}

Widget _buildList(List<String> options, List<String> selectedOptions, bool isSingleSelection, TextEditingController? textFieldController) {
  // ...
  if (isSingleSelection && selectedOptions.contains('Sí'))
    TextField(
      controller: textFieldController,
      decoration: InputDecoration(
        labelText: 'Por favor, especifica',
      ),
    ),
  // ...
}

Widget _buildSubmitButton() {
  return ElevatedButton(
    onPressed: () {
      if (_quirurgicosSeleccionados.contains('Sí')) {
        _quirurgicosSeleccionados.add(_quirurgicosController.text);
      }
      if (_transfusionalesSeleccionados.contains('Sí')) {
        _transfusionalesSeleccionados.add(_transfusionalesController.text);
      }
      if (_alergicosSeleccionados.contains('Sí')) {
        _alergicosSeleccionados.add(_alergicosController.text);
      }
      print('Patológicos: $_patologicosSeleccionados');
      print('Quirúrgicos: $_quirurgicosSeleccionados');
      print('Anestésicos: $_anestesicosSeleccionados');
      print('Alergicos: $_alergicosSeleccionados');
      print('Tóxicos: $_toxicosSeleccionados');
      print('Transfusionales: $_transfusionalesSeleccionados');
    },
    child: const Text('Siguiente'),
  );
}

*/