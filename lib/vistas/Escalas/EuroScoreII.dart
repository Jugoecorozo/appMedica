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
  String genero = 'no seleccionado';
  String creatinina = 'no seleccionado';
  bool dialisis = false;
  bool arteriopatia = false;
  bool movilidadReducida = false;
  bool cirugiaCardiacaPrevia = false;
  bool epoc = false;
  bool endocarditisActiva = false;
  bool situacionCritica = false;
  bool diabetesInsulina = false;
  String nyha = 'no seleccionado';
  bool angorInestable = false;
  String fraccionEyeccion = 'no seleccionado';
  bool iamReciente = false;
  String hipertensionPulmonar = 'no seleccionado';
  String tipoCirugia = 'no seleccionado';
  String intervencion = 'no seleccionado';
  bool cirugiaAortaToracica = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _edadController = TextEditingController();

  void updateScaleValue() {
    double resultado = calcularEuroSCOREII();
    widget.onValueUpdated('EuroScoreII', ' el riesgo de mortalidad es $resultado%');
  }

  // Coeficientes para cada variable
  double calcularCoeficienteEdad(int edad) {
    double baseCoeficiente = 0.0285181;
    return (edad <= 60) ? baseCoeficiente : baseCoeficiente * (edad - 60 + 1);
  }

  double obtenerCoeficiente(String tipo, dynamic valor) {
    switch (tipo) {
      case 'Genero':
        return (valor == 'Femenino') ? 0.2196434 : 0;
      case 'Creatinina':
        if (dialisis) return 0.6421508;
        if (valor == 'Severo') return 0.8592256;
        if (valor == 'Moderado') return 0.303553;
        return 0;
      case 'Arteriopatia':
        return valor ? 0.5360268 : 0;
      case 'MovilidadReducida':
        return valor ? 0.2407181 : 0;
      case 'CirugiaCardiacaPrevia':
        return valor ? 1.118599 : 0;
      case 'EPOC':
        return valor ? 0.1886564 : 0;
      case 'EndocarditisActiva':
        return valor ? 0.6194522 : 0;
      case 'SituacionCritica':
        return valor ? 1.086517 : 0;
      case 'DiabetesInsulina':
        return valor ? 0.3542749 : 0;
      case 'NYHA':
        switch (valor) {
          case 'II':
            return 0.1070545;
          case 'III':
            return 0.2958358;
          case 'IV':
            return 0.5597929;
          default:
            return 0;
        }
      case 'AngorInestable':
        return valor ? 0.2226147 : 0;
      case 'FraccionEyeccion':
        if (valor == '31-50%') return 0.3150652;
        if (valor == '21-30%') return 0.8084096;
        if (valor == '< 20%') return 0.9346919;
        return 0;
      case 'IAMReciente':
        return valor ? 0.1528943 : 0;
      case 'HipertensionPulmonar':
        if (valor == '31-55 mmHg') return 0.1788899;
        if (valor == '>55 mmHg') return 0.3491475;
        return 0;
      case 'TipoCirugia':
        switch (valor) {
          case 'Urgente':
            return 0.3174673;
          case 'Emergente':
            return 0.7039121;
          case 'De rescate':
            return 1.362947;
          default:
            return 0;
        }
      case 'Intervencion':
        switch (valor) {
          case 'Simple No CABG':
            return 0.0062118;
          case '2 procedimientos':
            return 0.5521478;
          case '3 procedimientos':
            return 0.9724533;
          default:
            return 0;
        }
      case 'CirugiaAortaToracica':
        return valor ? 0.6527205 : 0;
      default:
        return 0;
    }
  }

  // Método para calcular el riesgo total de mortalidad
  double calcularEuroSCOREII() {
    double beta0 = -5.324537;
    double beta1 = calcularCoeficienteEdad(edad) +
        obtenerCoeficiente('Genero', genero) +
        obtenerCoeficiente('Creatinina', creatinina) +
        obtenerCoeficiente('Arteriopatia', arteriopatia) +
        obtenerCoeficiente('MovilidadReducida', movilidadReducida) +
        obtenerCoeficiente('CirugiaCardiacaPrevia', cirugiaCardiacaPrevia) +
        obtenerCoeficiente('EPOC', epoc) +
        obtenerCoeficiente('EndocarditisActiva', endocarditisActiva) +
        obtenerCoeficiente('SituacionCritica', situacionCritica) +
        obtenerCoeficiente('DiabetesInsulina', diabetesInsulina) +
        obtenerCoeficiente('NYHA', nyha) +
        obtenerCoeficiente('AngorInestable', angorInestable) +
        obtenerCoeficiente('FraccionEyeccion', fraccionEyeccion) +
        obtenerCoeficiente('IAMReciente', iamReciente) +
        obtenerCoeficiente('HipertensionPulmonar', hipertensionPulmonar) +
        obtenerCoeficiente('TipoCirugia', tipoCirugia) +
        obtenerCoeficiente('Intervencion', intervencion) +
        obtenerCoeficiente('CirugiaAortaToracica', cirugiaAortaToracica);
    
    print ('valor coeficiente total: $beta1');

    double riesgo = (beta0 + beta1);
    double eLogit = 2.71828;
    num variablew = pow(eLogit, riesgo);
    double probabilidadMortalidad = (variablew) / (1 +variablew);
    return probabilidadMortalidad * 100;
  }

  Widget buildRadioButton(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Row(
          children: [
            Radio(
              value: true,
              groupValue: value,
              onChanged: (newValue) {
                setState(() {
                  onChanged(newValue as bool);
                  updateScaleValue();
                });
              },
            ),
            Text('Sí'),
            Radio(
              value: false,
              groupValue: value,
              onChanged: (newValue) {
                setState(() {
                  onChanged(newValue as bool);
                  updateScaleValue();
                });
              },
            ),
            Text('No'),
          ],
        ),
      ],
    );
  }

  Widget buildDropdownButton(String label, String value, List<String> items, Function(String) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label, hintText: 'Seleccione una opción'),
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          onChanged(newValue!);
          updateScaleValue();
        });
      },
      validator: (value) {
        if (value == 'no seleccionado') {
          return 'Por favor seleccione una opción';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         const Text(
          'EuroSCORE II',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Edad
                TextFormField(
                  controller: _edadController,
                  decoration: InputDecoration(labelText: 'Edad'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una edad';
                    }
                    final int? edad = int.tryParse(value);
                    if (edad == null || edad < 0) {
                      return 'Por favor ingrese un número válido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      edad = int.tryParse(value) ?? 0;
                      updateScaleValue();
                    });
                  },
                ),

                const SizedBox(height: 16.0),
        
                buildDropdownButton('Género', genero, ['no seleccionado', 'Masculino', 'Femenino'], (newValue) {
                  genero = newValue;
                }),
                        const SizedBox(height: 16.0),

                buildDropdownButton('Creatinina (ClCr)', creatinina, ['no seleccionado', 'Normal', 'Moderado', 'Severo'], (newValue) {
                  creatinina = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('Diálisis', dialisis, (newValue) {
                  dialisis = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('Arteriopatía extracardiaca', arteriopatia, (newValue) {
                  arteriopatia = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('Movilidad reducida', movilidadReducida, (newValue) {
                  movilidadReducida = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('Cirugía cardíaca previa', cirugiaCardiacaPrevia, (newValue) {
                  cirugiaCardiacaPrevia = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('EPOC', epoc, (newValue) {
                  epoc = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('Endocarditis activa', endocarditisActiva, (newValue) {
                  endocarditisActiva = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('Situación crítica', situacionCritica, (newValue) {
                  situacionCritica = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('Diabetes insulinodependiente', diabetesInsulina, (newValue) {
                  diabetesInsulina = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildDropdownButton('NYHA', nyha, ['no seleccionado', 'I', 'II', 'III', 'IV'], (newValue) {
                  nyha = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('Angor inestable', angorInestable, (newValue) {
                  angorInestable = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildDropdownButton('Fracción de eyección', fraccionEyeccion, ['no seleccionado', '> 50%', '31-50%', '21-30%', '< 20%'], (newValue) {
                  fraccionEyeccion = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('IAM reciente', iamReciente, (newValue) {
                  iamReciente = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildDropdownButton('Hipertensión pulmonar', hipertensionPulmonar, ['no seleccionado', 'Normal', '31-55 mmHg', '>55 mmHg'], (newValue) {
                  hipertensionPulmonar = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildDropdownButton('Tipo de cirugía', tipoCirugia, ['no seleccionado', 'Electiva', 'Urgente', 'Emergente', 'De rescate'], (newValue) {
                  tipoCirugia = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildDropdownButton('Intervención', intervencion, ['no seleccionado', 'CABG aislada', 'Simple No CABG', '2 procedimientos', '3 procedimientos'], (newValue) {
                  intervencion = newValue;
                }),
        
                const SizedBox(height: 16.0),
                buildRadioButton('Cirugía sobre la aorta torácica', cirugiaAortaToracica, (newValue) {
                  cirugiaAortaToracica = newValue;
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _edadController.dispose();
    super.dispose();
  }
}