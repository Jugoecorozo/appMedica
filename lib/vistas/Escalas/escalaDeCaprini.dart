import 'package:flutter/material.dart';

class Caprini extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const Caprini({super.key, required this.onValueUpdated});

  @override
  State<Caprini> createState() => _CapriniState();
}

class _CapriniState extends State<Caprini> {
  String? selectedAge;
  String? selectedSurgeryType;
  int puntosTotales = 0;

  bool cirugiaMayor = false;
  bool insuficienciaCardiaca = false;
  bool sepsis = false;
  bool neumonia = false;
  bool embarazoPostparto = false;
  bool yesoInmovilizador = false;
  bool fracturaCadera = false;
  bool infarto = false;
  bool politraumatismo = false;
  bool lesionMedulaEspinal = false;

  bool venasVaricosas = false;
  bool edemaPelvico = false;
  bool accesoVenosoCentral = false;
  bool antecedentesTVP_EP = false;
  bool antecedentesFamiliaresTrombosis = false;
  bool factorVLeiden = false;
  bool homocisteinaElevada = false;
  bool anticoagulanteLupico = false;
  bool anticuerposAnticardiolipina = false;
  bool trombocitopeniaInducidaHeparina = false;
  bool otraTrombofilia = false;

  bool padecimientoMedico = false;
  bool pacienteConfinadoCama = false;

  bool antecedentesEnfermedadInflamatoria = false;
  bool indiceMasaCorporal = false;
  bool infartoMiocardio = false;
  bool enfermedadPulmonarObstructiva = false;
  bool otrosFactoresRiesgo = false;

  String calcularCategoria(int puntos) {
    if (puntos == 0) {
      return 'Muy bajo';
    } else if (puntos <= 2) {
      return 'Bajo';
    } else if (puntos <= 4) {
      return 'Moderado';
    } else if (puntos <= 6) {
      return 'Alto';
    } else if (puntos <= 8) {
      return 'Alto';
    } else {
      return 'Muy Alto';
    }
  }

  String calcularRiesgo(int puntos) {
    if (puntos == 0) {
      return 'Mínimo';
    } else if (puntos <= 2) {
      return 'Mínimo';
    } else if (puntos <= 4) {
      return '0.7%';
    } else if (puntos <= 6) {
      return '1.8%';
    } else if (puntos <= 8) {
      return '4%';
    } else {
      return '10.7%';
    }
  }

  String calcularRecomendaciones(int puntos) {
    if (puntos == 0) {
      return 'Deambulación precoz o con ayuda del equipo\n▪ Dispositivos de compresión neumática o medias de compresión graduada';
    } else if (puntos <= 2) {
      return 'Dispositivos de compresión neumática con o sin medias de compresión graduada';
    } else if (puntos <= 4) {
      return 'Dispositivos de compresión neumática con o sin medias de compresión graduada';
    } else if (puntos <= 6) {
      return 'Dispositivos de compresión neumática con dosis baja de heparina o heparina de bajo peso molecular';
    } else if (puntos <= 8) {
      return 'Dispositivos de compresión neumática con dosis baja de heparina o heparina de bajo peso molecular';
    } else {
      return 'Dispositivos de compresión neumática con dosis baja de heparina o heparina de bajo peso molecular';
    }
  }

  void _actualizarPuntos() {
    int nuevosPuntos = 0;

    // Calcular puntos para la edad
    switch (selectedAge) {
      case '<40':
        nuevosPuntos += 0;
        break;
      case '41-60':
        nuevosPuntos += 1;
        break;
      case '61-74':
        nuevosPuntos += 2;
        break;
      case '>75':
        nuevosPuntos += 3;
        break;
    }

    // Calcular puntos para el tipo de cirugía
    switch (selectedSurgeryType) {
      case 'Menor':
        nuevosPuntos += 1;
        break;
      case '>45 min':
        nuevosPuntos += 2;
        break;
      case 'Laparoscópica':
        nuevosPuntos += 2;
        break;
      case 'Artroplastia':
        nuevosPuntos += 5;
        break;
    }

// preguntas de si o no

    nuevosPuntos += (cirugiaMayor ? 1 : 0);
    nuevosPuntos += (insuficienciaCardiaca ? 1 : 0);
    nuevosPuntos += (sepsis ? 1 : 0);
    nuevosPuntos += (neumonia ? 1 : 0);
    nuevosPuntos += (embarazoPostparto ? 1 : 0);
    nuevosPuntos += (yesoInmovilizador ? 2 : 0);
    nuevosPuntos += (fracturaCadera ? 5 : 0);
    nuevosPuntos += (infarto ? 5 : 0);
    nuevosPuntos += (politraumatismo ? 5 : 0);
    nuevosPuntos += (lesionMedulaEspinal ? 5 : 0);
    nuevosPuntos += (venasVaricosas ? 1 : 0);
    nuevosPuntos += (edemaPelvico ? 1 : 0);
    nuevosPuntos += (accesoVenosoCentral ? 2 : 0);
    nuevosPuntos += (antecedentesTVP_EP ? 3 : 0);
    nuevosPuntos += (antecedentesFamiliaresTrombosis ? 3 : 0);
    nuevosPuntos += (factorVLeiden ? 3 : 0);
    nuevosPuntos += (homocisteinaElevada ? 3 : 0);
    nuevosPuntos += (anticoagulanteLupico ? 3 : 0);
    nuevosPuntos += (anticuerposAnticardiolipina ? 3 : 0);
    nuevosPuntos += (trombocitopeniaInducidaHeparina ? 3 : 0);
    nuevosPuntos += (otraTrombofilia ? 3 : 0);
    nuevosPuntos += (padecimientoMedico ? 1 : 0);
    nuevosPuntos += (pacienteConfinadoCama ? 2 : 0);
    nuevosPuntos += (antecedentesEnfermedadInflamatoria ? 1 : 0);
    nuevosPuntos += (indiceMasaCorporal ? 1 : 0);
    nuevosPuntos += (infartoMiocardio ? 1 : 0);
    nuevosPuntos += (enfermedadPulmonarObstructiva ? 1 : 0);
    nuevosPuntos += (otrosFactoresRiesgo ? 1 : 0);

    setState(() {
      puntosTotales = nuevosPuntos;
    });

    String categoria = calcularCategoria(puntosTotales);
    String riesgo = calcularRiesgo(puntosTotales);
    String recomendaciones = calcularRecomendaciones(puntosTotales);

    String resultados =
        '$puntosTotales puntos, riesgo $categoria ($riesgo) para presentar trombosis venosa, se recomienda $recomendaciones.';
    widget.onValueUpdated('ESCALA DE CAPRINI', resultados);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Escala De Caprini Para Riesgo De Trombosis Venosa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        DropdownButton<String>(
          isExpanded: true,
          hint: const Text('Selecciona una edad'),
          value: selectedAge,
          onChanged: (String? newValue) {
            setState(() {
              selectedAge = newValue;
              _actualizarPuntos();
            });
          },
          items: <String>[
            '<40',
            '41-60',
            '61-74',
            '>75',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        DropdownButton<String>(
          isExpanded: true,
          hint: const Text('Selecciona un tipo de cirugía'),
          value: selectedSurgeryType,
          onChanged: (String? newValue) {
            setState(() {
              selectedSurgeryType = newValue;
              _actualizarPuntos();
            });
          },
          items: <String>[
            'Menor',
            '>45 min',
            'Laparoscópica',
            'Artroplastia',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        const Text('Preguntas:'),
        CheckboxListTile(
          title: const Text('¿Cirugía mayor?'),
          value: cirugiaMayor,
          onChanged: (bool? value) {
            setState(() {
              cirugiaMayor = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Insuficiencia cardiaca congestiva?'),
          value: insuficienciaCardiaca,
          onChanged: (bool? value) {
            setState(() {
              insuficienciaCardiaca = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Sepsis?'),
          value: sepsis,
          onChanged: (bool? value) {
            setState(() {
              sepsis = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Neumonía?'),
          value: neumonia,
          onChanged: (bool? value) {
            setState(() {
              neumonia = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Embarazo y postparto?'),
          value: embarazoPostparto,
          onChanged: (bool? value) {
            setState(() {
              embarazoPostparto = value!;
              _actualizarPuntos();
            });
          },
        ),
        const Text('Enfermedad venosa o trastorno de la coagulación:'),
        CheckboxListTile(
          title: const Text('¿Venas varicosas?'),
          value: venasVaricosas,
          onChanged: (bool? value) {
            setState(() {
              venasVaricosas = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Edema de miembros inferiores?'),
          value: edemaPelvico,
          onChanged: (bool? value) {
            setState(() {
              edemaPelvico = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Acceso venoso central actual?'),
          value: accesoVenosoCentral,
          onChanged: (bool? value) {
            setState(() {
              accesoVenosoCentral = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Antecedentes de TVP / EP?'),
          value: antecedentesTVP_EP,
          onChanged: (bool? value) {
            setState(() {
              antecedentesTVP_EP = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Antecedentes familiares de trombosis?'),
          value: antecedentesFamiliaresTrombosis,
          onChanged: (bool? value) {
            setState(() {
              antecedentesFamiliaresTrombosis = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Factor V Leiden positivo?'),
          value: factorVLeiden,
          onChanged: (bool? value) {
            setState(() {
              factorVLeiden = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Homocisteína sérica elevada?'),
          value: homocisteinaElevada,
          onChanged: (bool? value) {
            setState(() {
              homocisteinaElevada = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Anticoagulante lúpico positivo?'),
          value: anticoagulanteLupico,
          onChanged: (bool? value) {
            setState(() {
              anticoagulanteLupico = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Anticuerpos anticardiolipina elevados?'),
          value: anticuerposAnticardiolipina,
          onChanged: (bool? value) {
            setState(() {
              anticuerposAnticardiolipina = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Trombocitopenia inducida por heparina?'),
          value: trombocitopeniaInducidaHeparina,
          onChanged: (bool? value) {
            setState(() {
              trombocitopeniaInducidaHeparina = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Otra trombofilia congénita o adquirida?'),
          value: otraTrombofilia,
          onChanged: (bool? value) {
            setState(() {
              otraTrombofilia = value!;
              _actualizarPuntos();
            });
          },
        ),
        const Text('Morbilidades:'),
        CheckboxListTile(
          title: const Text('¿Padecimiento médico, actualmente en reposo en cama?'),
          value: padecimientoMedico,
          onChanged: (bool? value) {
            setState(() {
              padecimientoMedico = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Paciente confinado en cama > 72 horas?'),
          value: pacienteConfinadoCama,
          onChanged: (bool? value) {
            setState(() {
              pacienteConfinadoCama = value!;
              _actualizarPuntos();
            });
          },
        ),
        const Text('Otros:'),
        CheckboxListTile(
          title: const Text('¿Antecedentes de enfermedad inflamatoria intestinal?'),
          value: antecedentesEnfermedadInflamatoria,
          onChanged: (bool? value) {
            setState(() {
              antecedentesEnfermedadInflamatoria = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Índice de masa corporal > 25?'),
          value: indiceMasaCorporal,
          onChanged: (bool? value) {
            setState(() {
              indiceMasaCorporal = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Infarto agudo al miocardio?'),
          value: infartoMiocardio,
          onChanged: (bool? value) {
            setState(() {
              infartoMiocardio = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text('¿Enfermedad pulmonar obstructiva crónica?'),
          value: enfermedadPulmonarObstructiva,
          onChanged: (bool? value) {
            setState(() {
              enfermedadPulmonarObstructiva = value!;
              _actualizarPuntos();
            });
          },
        ),
        CheckboxListTile(
          title: const Text(
              '¿Otros factores de riesgo? (anticonceptivos orales o reemplazo hormonal, ≥3 abortos espontáneos o nacimiento prematuro con toxemia o lactante con retraso del crecimiento)'),
          value: otrosFactoresRiesgo,
          onChanged: (bool? value) {
            setState(() {
              otrosFactoresRiesgo = value!;
              _actualizarPuntos();
            });
          },
        ),
        const SizedBox(height: 20),
        Text('Puntos Totales: $puntosTotales'),
      ],
    );
  }
}