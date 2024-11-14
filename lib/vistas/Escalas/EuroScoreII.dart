import 'dart:math';
import 'package:flutter/material.dart';

class EuroScoreIIScreen extends StatefulWidget {
  final void Function(String, String) onValueUpdated;
  const EuroScoreIIScreen({super.key, required this.onValueUpdated});
  @override
  _EuroScoreIIScreenState createState() => _EuroScoreIIScreenState();
}

class _EuroScoreIIScreenState extends State<EuroScoreIIScreen> {
  // Variables para cada factor de riesgo
  int edad = 0;
  String genero = 'Masculino';
  double creatinina = 0;
  bool dialisis = false;
  bool arteriopatia = false;
  bool movilidadReducida = false;
  bool cirugiaCardiacaPrevia = false;
  String nyha = 'I';
  bool endocarditisActiva = false;
  bool situacionCritica = false;
  bool diabetesInsulina = false;
  String fraccionEyeccion = '> 50%';
  bool iamReciente = false;
  String tipoCirugia = 'Electiva';

  void updateScaleValue(String value) {
    setState(() {
      widget.onValueUpdated('EuroScoreII', value);
    });
  }

  // Coeficientes para cada variable
  double calcularCoeficienteEdad(int edad) {
    return (edad > 60) ? (edad - 60) * 0.0285181 : 0.0285181;
  }

  double obtenerCoeficienteGenero(String genero) {
    return (genero == 'Femenino') ? 0.2196434 : 0;
  }

  double obtenerCoeficienteCreatinina(double creatinina) {
    if (creatinina < 50) return 0;
    if (creatinina <= 85) return 0.303553;
    return 0.8592256;
  }

  double obtenerCoeficienteDialisis(bool dialisis) {
    return dialisis ? 0.6421508 : 0;
  }

  double obtenerCoeficienteArteriopatia(bool arteriopatia) {
    return arteriopatia ? 0.5360268 : 0;
  }

  double obtenerCoeficienteMovilidadReducida(bool movilidadReducida) {
    return movilidadReducida ? 0.2407181 : 0;
  }

  double obtenerCoeficienteCirugiaCardiacaPrevia(bool cirugiaCardiacaPrevia) {
    return cirugiaCardiacaPrevia ? 1.118599 : 0;
  }

  double obtenerCoeficienteNYHA(String nyha) {
    switch (nyha) {
      case 'II':
        return 0.1070545;
      case 'III':
        return 0.2958358;
      case 'IV':
        return 0.5597929;
      default:
        return 0;
    }
  }

  double obtenerCoeficienteEndocarditisActiva(bool endocarditisActiva) {
    return endocarditisActiva ? 0.6194522 : 0;
  }

  double obtenerCoeficienteSituacionCritica(bool situacionCritica) {
    return situacionCritica ? 1.086517 : 0;
  }

  double obtenerCoeficienteDiabetesInsulina(bool diabetesInsulina) {
    return diabetesInsulina ? 0.3542749 : 0;
  }

  double obtenerCoeficienteFraccionEyeccion(String fraccion) {
    if (fraccion == '31-50%') return 0.3150652;
    if (fraccion == '21-30%') return 0.8084096;
    if (fraccion == '< 20%') return 0.9346919;
    return 0;
  }

  double obtenerCoeficienteIAMReciente(bool iamReciente) {
    return iamReciente ? 0.1528943 : 0;
  }

  double obtenerCoeficienteTipoCirugia(String tipo) {
    switch (tipo) {
      case 'Urgente':
        return 0.3174673;
      case 'Emergente':
        return 0.7039121;
      case 'De rescate':
        return 1.362947;
      default:
        return 0;
    }
  }

  // Método para calcular el riesgo total de mortalidad
  double calcularEuroSCOREII() {
    double beta0 = -5.324537;
    double beta1 = calcularCoeficienteEdad(edad) +
        obtenerCoeficienteGenero(genero) +
        obtenerCoeficienteCreatinina(creatinina) +
        obtenerCoeficienteDialisis(dialisis) +
        obtenerCoeficienteArteriopatia(arteriopatia) +
        obtenerCoeficienteMovilidadReducida(movilidadReducida) +
        obtenerCoeficienteCirugiaCardiacaPrevia(cirugiaCardiacaPrevia) +
        obtenerCoeficienteNYHA(nyha) +
        obtenerCoeficienteEndocarditisActiva(endocarditisActiva) +
        obtenerCoeficienteSituacionCritica(situacionCritica) +
        obtenerCoeficienteDiabetesInsulina(diabetesInsulina) +
        obtenerCoeficienteFraccionEyeccion(fraccionEyeccion) +
        obtenerCoeficienteIAMReciente(iamReciente) +
        obtenerCoeficienteTipoCirugia(tipoCirugia);

    double riesgo = (beta0 + beta1);
    double eLogit = 2.71828;
    double probabilidadMortalidad = (pow(eLogit, riesgo)) / (1 + pow(eLogit, riesgo));
    return probabilidadMortalidad * 100;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Edad
          TextFormField(
            decoration: InputDecoration(labelText: 'Edad'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                edad = int.parse(value);
              });
            },
          ),

          // Género
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Género'),
            value: genero,
            items: ['Masculino', 'Femenino'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                genero = newValue!;
              });
            },
          ),

          // Creatinina
          TextFormField(
            decoration: InputDecoration(labelText: 'Creatinina (mg/dL)'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                creatinina = double.parse(value);
              });
            },
          ),

          // Diálisis
          SwitchListTile(
            title: Text('Diálisis'),
            value: dialisis,
            onChanged: (value) {
              setState(() {
                dialisis = value;
              });
            },
          ),

          // Arteriopatía extracardiaca
          SwitchListTile(
            title: Text('Arteriopatía extracardiaca'),
            value: arteriopatia,
            onChanged: (value) {
              setState(() {
                arteriopatia = value;
              });
            },
          ),

          // Movilidad reducida
          SwitchListTile(
            title: Text('Movilidad reducida'),
            value: movilidadReducida,
            onChanged: (value) {
              setState(() {
                movilidadReducida = value;
              });
            },
          ),

          // Cirugía cardíaca previa
          SwitchListTile(
            title: Text('Cirugía cardíaca previa'),
            value: cirugiaCardiacaPrevia,
            onChanged: (value) {
              setState(() {
                cirugiaCardiacaPrevia = value;
              });
            },
          ),

          // NYHA
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'NYHA'),
            value: nyha,
            items: ['I', 'II', 'III', 'IV'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                nyha = newValue!;
              });
            },
          ),

          // Fracción de eyección
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Fracción de eyección'),
            value: fraccionEyeccion,
            items: ['> 50%', '31-50%', '21-30%', '< 20%'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                fraccionEyeccion = newValue!;
              });
            },
          ),

          // Mostrar resultado
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                double resultado = calcularEuroSCOREII();
                updateScaleValue('EurosScoreII: el riesgo de mortalidad es $resultado%');
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('EuroScore II'),
                    content: Text(
                        'El riesgo de mortalidad es: ${resultado.toStringAsFixed(2)}%'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Calcular'),
            ),
          ),
        ],
      ),
    );
  }
}