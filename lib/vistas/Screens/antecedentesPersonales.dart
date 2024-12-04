import 'dart:math';

import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/Screens/paraclinicos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    'No tiene antecedentes anestésicos',
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

  final TextEditingController _quirurgicosController = TextEditingController();
  final TextEditingController _transfusionalesController =
      TextEditingController();
  final TextEditingController _alergicosController = TextEditingController();

  // Mapa para almacenar los filtros de cada sección
  Map<String, String> filtros = {
    'Antecedentes Patológicos': '',
    'Antecedentes Quirúrgicos': '',
    'Antecedentes Transfusionales': '',
    'Antecedentes Alérgicos': '',
    'Antecedentes Anestésicos': '',
    'Complicaciones Anestésicas': '',
    'Antecedentes Tóxicos': '',
  };

  int cigarrillos=1;
    int aniosFumando=1;

  // Método para actualizar el filtro de una sección específica
  void actualizarFiltro(String title, String value) {
    setState(() {
      filtros[title] = value.toLowerCase();
    });
  }

  List<String> filtrarOpciones(List<String> opciones, String filtro) {
    return opciones.where((opcion) {
      return opcion.toLowerCase().contains(filtro.toLowerCase());
    }).toList();
  }

  void calcularASA() {
  final asaII = [
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
  ];

  final asaIII = [
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
  ];

  final asaIV = [
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
  ];

  final asaV = [
    'Politraumatizado severo.',
    'Rotura uterina.',
    'Desprendimiento de placenta.',
    'Daño hepático crónico con encefalopatía hepática.',
    'Requerimiento de ECMO.',
    'Disfunción orgánica múltiple.',
    'Isquemia intestinal.',
    'Insuficiencia cardiaca congestiva descompensada.',
  ];

  final asaVI = [
    'Con muerte cerebral: Donante de órganos.',
  ];

  int asa = 1;

  for (var patologia in _patologicosSeleccionados) {
    if (asaVI.contains(patologia)) {
      asa = 6;
      break;
    } else if (asaV.contains(patologia)) {
      asa = max(asa, 5);
    } else if (asaIV.contains(patologia)) {
      asa = max(asa, 4);
    } else if (asaIII.contains(patologia)) {
      asa = max(asa, 3);
    } else if (asaII.contains(patologia)) {
      asa = max(asa, 2);
    }
  }


  Provider.of<datosFormulario>(context, listen: false).updateASA(asa);
}
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildPatologicosSection(),
                  ],
                ),
              ),
            ),  
            const SizedBox(height: 16),
            _buildQuirurgicosSection(),
            const SizedBox(height: 16),
            _buildAnestesicosSection(),
            const SizedBox(height: 16),
            _buildAlergicosSection(),
            const SizedBox(height: 16),
            _buildToxicosSection(),
            const SizedBox(height: 16),
            _buildTransfusionalesSection(),
            const SizedBox(height: 16),
            _buildSubmitButton(),

            Consumer<datosFormulario>(
                  builder: (context, calculos, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(' ${calculos.patologias}'),
                        Text(' ${calculos.quirurgicos}'),
                        Text(' ${calculos.anestesicos}'),
                        Text(' ${calculos.complicaciones}'),
                        Text('IPA : ${calculos.ipa}'),
                        Text(' ${calculos.alergicos}'),
                        Text(' ${calculos.toxicos}'),
                        Text(' ${calculos.transfusion}')
                      ],
                    );
                  },
                ),

          ],
        ),
      ),
    );
  }

  Widget _buildPatologicosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Antecedentes Patológicos:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    actualizarFiltro('Antecedentes Patológicos', value);
                  },
                ),
                const SizedBox(height: 8),
                _buildList(patologicos..sort(), _patologicosSeleccionados,
                    'Antecedentes Patológicos', false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuirurgicosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Antecedentes Quirúrgicos:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _buildList(quirurgicos, _quirurgicosSeleccionados,
                    'Antecedentes Quirúrgicos',true),
                if (_quirurgicosSeleccionados.contains('Sí'))
                  TextField(
                    controller: _quirurgicosController,
                    decoration: const InputDecoration(
                      labelText: 'Especifique',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnestesicosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Antecedentes Anestésicos:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildList(anestesicos, _anestesicosSeleccionados,
                    'Antecedentes Anestésicos', true),
                const SizedBox(height: 8),
                 if (!_anestesicosSeleccionados.contains('No tiene antecedentes anestésicos')) ...[
                  const Text(
                  'Complicaciones Anestésicas:',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                _buildList(
                    complicacionesAnestesicas,
                    _complicacionesAnestesicasSeleccionadas,
                    'Complicaciones Anestésicas', false),
                 ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAlergicosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Antecedentes Alérgicos:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _buildList(alergicos, 
                _alergicosSeleccionados,
                'Antecedentes Alérgicos', 
                true),
                if (_alergicosSeleccionados.contains('Sí'))
                  TextField(
                    controller: _alergicosController,
                    decoration: const InputDecoration(
                      labelText: 'Especifique',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        if (!_alergicosSeleccionados.contains(value)) {
                          _alergicosSeleccionados.add(value);
                        }
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
    
  Widget _buildToxicosSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Antecedentes Tóxicos:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      SingleChildScrollView(
        child: Column(
          children: [
            _buildList(toxicos, _toxicosSeleccionados, 'Antecedentes Tóxicos', false),
            if (_toxicosSeleccionados.contains('Otros'))
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Especifique',
                ),
                onSubmitted: (value) {
                  setState(() {
                    if (!_toxicosSeleccionados.contains(value)) {
                      _toxicosSeleccionados.add(value);
                    }
                  });
                },
              ),
            if (_toxicosSeleccionados.contains('Tabaquismo')) ...[
              const SizedBox(height: 8),
              const Text('Frecuencia de consumo diario:'),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Número de cigarrillos al día',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    cigarrillos = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 8),
              const Text('Número de años fumando:'),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Años fumando',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                   aniosFumando = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 8),
              ],
          ],
        ),
      ),
    ],
  );
}

  Widget _buildTransfusionalesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Antecedentes Transfusionales:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _buildList(
                  transfusionales, 
                  _transfusionalesSeleccionados,
                  'Antecedentes Transfusionales',
                  true),
                if (_transfusionalesSeleccionados.contains('Sí'))
                  TextField(
                    controller: _transfusionalesController,
                    decoration: const InputDecoration(
                      labelText: 'Especifique',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        if (!_transfusionalesSeleccionados.contains(value)) {
                          _transfusionalesSeleccionados.add(value);
                        }
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList(
  List<String> options, 
  List<String> selectedOptions, 
  String sectionTitle, 
  bool isSingleSelection, 
) {
  final String filtro = filtros[sectionTitle]!;
  final List<String> opcionesFiltradas = filtrarOpciones(options, filtro);
  return Column(
    children: opcionesFiltradas.map((option) {
      return CheckboxListTile(
        title: Text(option),
        value: selectedOptions.contains(option),
        onChanged: (value) {
          setState(() {
            if (value != null && value) {
              if (isSingleSelection) {
                selectedOptions.clear(); // Si es selección única, limpia todas las selecciones existentes
              }
              selectedOptions.add(option);
            } else {
              selectedOptions.remove(option);
            }
          });
        },
      );
    }).toList(),
  );
}

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_quirurgicosSeleccionados.contains('Sí')) {
          _quirurgicosSeleccionados.clear();
          _quirurgicosSeleccionados.add(_quirurgicosController.text);
        }
        if (_transfusionalesSeleccionados.contains('Sí')) {
          _transfusionalesSeleccionados.clear();
          _transfusionalesSeleccionados.add(_transfusionalesController.text);
        }
        if (_alergicosSeleccionados.contains('Sí')) {
          _alergicosSeleccionados.clear();
          _alergicosSeleccionados.add(_alergicosController.text);
        }
        Provider.of<datosFormulario>(context, listen: false).updatePatologias(_patologicosSeleccionados);
        Provider.of<datosFormulario>(context, listen: false).updateQuirurgicos(_quirurgicosSeleccionados);
        Provider.of<datosFormulario>(context, listen: false).updateAnestesicos(_anestesicosSeleccionados);
        Provider.of<datosFormulario>(context, listen: false).updateComplicaciones(_complicacionesAnestesicasSeleccionadas);
        Provider.of<datosFormulario>(context, listen: false).updateAlergicos(_alergicosSeleccionados);
        Provider.of<datosFormulario>(context, listen: false).updateToxicos(_toxicosSeleccionados);
        Provider.of<datosFormulario>(context, listen: false).updateTransfusion(_transfusionalesSeleccionados);
        Provider.of<datosFormulario>(context, listen: false).updateIPA(cigarrillos, aniosFumando);
        calcularASA();
        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) =>  const ParaclinicosWidget())); //aqui deberia ir a examen fisico
      },
      child: const Text('Siguiente'),
    );
    
  }
}
