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
  String creatinina = 'Normal';
  bool dialisis = false;
  bool arteriopatia = false;
  bool movilidadReducida = false;
  bool cirugiaCardiacaPrevia = false;
  bool epoc = false;
  bool endocarditisActiva = false;
  bool situacionCritica = false;
  bool diabetesInsulina = false;
  String nyha = 'I';
  bool angorInestable = false;
  String fraccionEyeccion = '> 50%';
  bool iamReciente = false;
  String hipertensionPulmonar = 'Normal';
  String tipoCirugia = 'Electiva';
  String intervencion = 'CABG aislada';
  bool cirugiaAortaToracica = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _edadController = TextEditingController();

  void updateScaleValue() {
    double resultado = calcularEuroSCOREII();
    print('EuroSCOREII: el riesgo de mortalidad es $resultado%');
    widget.onValueUpdated('EuroScoreII', 'EurosScoreII: el riesgo de mortalidad es $resultado%');
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
    double probabilidadMortalidad = (pow(eLogit, riesgo)) / (1 + pow(eLogit, riesgo));
    return probabilidadMortalidad * 100;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  updateScaleValue();
                });
              },
            ),

            // Creatinina
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Creatinina (ClCr)'),
              value: creatinina,
              items: ['Normal', 'Moderado', 'Severo'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  creatinina = newValue!;
                  updateScaleValue();
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
                  updateScaleValue();
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
                  updateScaleValue();
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
                  updateScaleValue();
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
                  updateScaleValue();
                });
              },
            ),

            // EPOC
            SwitchListTile(
              title: Text('EPOC'),
              value: epoc,
              onChanged: (value) {
                setState(() {
                  epoc = value;
                  updateScaleValue();
                });
              },
            ),

            // Endocarditis activa
            SwitchListTile(
              title: Text('Endocarditis activa'),
              value: endocarditisActiva,
              onChanged: (value) {
                setState(() {
                  endocarditisActiva = value;
                  updateScaleValue();
                });
              },
            ),

            // Situación crítica
            SwitchListTile(
              title: Text('Situación crítica'),
              value: situacionCritica,
              onChanged: (value) {
                setState(() {
                  situacionCritica = value;
                  updateScaleValue();
                });
              },
            ),

            // Diabetes insulinodependiente
            SwitchListTile(
              title: Text('Diabetes insulinodependiente'),
              value: diabetesInsulina,
              onChanged: (value) {
                setState(() {
                  diabetesInsulina = value;
                  updateScaleValue();
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
                  updateScaleValue();
                });
              },
            ),

            // Angor inestable
            SwitchListTile(
              title: Text('Angor inestable'),
              value: angorInestable,
              onChanged: (value) {
                setState(() {
                  angorInestable = value;
                  updateScaleValue();
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
                  updateScaleValue();
                });
              },
            ),

            // IAM reciente
            SwitchListTile(
              title: Text('IAM reciente'),
              value: iamReciente,
              onChanged: (value) {
                setState(() {
                  iamReciente = value;
                  updateScaleValue();
                });
              },
            ),

            // Hipertensión pulmonar
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Hipertensión pulmonar'),
              value: hipertensionPulmonar,
              items: ['Normal', '31-55 mmHg', '>55 mmHg'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  hipertensionPulmonar = newValue!;
                  updateScaleValue();
                });
              },
            ),

            // Tipo de cirugía
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Tipo de cirugía'),
              value: tipoCirugia,
              items: ['Electiva', 'Urgente', 'Emergente', 'De rescate'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  tipoCirugia = newValue!;
                  updateScaleValue();
                });
              },
            ),

            // Intervención
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Intervención'),
              value: intervencion,
              items: ['CABG aislada', 'Simple No CABG', '2 procedimientos', '3 procedimientos'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  intervencion = newValue!;
                  updateScaleValue();
                });
              },
            ),

            // Cirugía sobre la aorta torácica
            SwitchListTile(
              title: Text('Cirugía sobre la aorta torácica'),
              value: cirugiaAortaToracica,
              onChanged: (value) {
                setState(() {
                  cirugiaAortaToracica = value;
                  updateScaleValue();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _edadController.dispose();
    super.dispose();
  }
}