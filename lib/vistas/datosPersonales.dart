import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/antecedentesPersonales.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class datosPersonales extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _fechaNacimientoController = TextEditingController();
  String _sexo = 'Masculino';
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _tallaController = TextEditingController();

  RegExp _onlyLetters = RegExp(r'^[a-zA-Z ]+$');
  RegExp _onlyNumbers = RegExp(r'^[0-9.]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Personales'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }else if (!_onlyLetters.hasMatch(value)) {
                      return 'Por favor ingresa un nombre válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _fechaNacimientoController,
                  decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MMM-yyyy').format(pickedDate);
                      _fechaNacimientoController.text =
                          formattedDate.toString();
                    }
                  },
                  readOnly: true,
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: _sexo,
                  onChanged: (value) {
                    _sexo = value!;
                  },
                  items: ['Masculino', 'Femenino']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Sexo'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _pesoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Peso (kg)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa el peso';
                    }else if (!_onlyNumbers.hasMatch(value)) {
                      return 'Por favor ingresa un peso válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _tallaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Talla (m)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa la talla';
                    }else if (!_onlyNumbers.hasMatch(value)) {
                      return 'Por favor ingresa una talla válida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        double peso = double.parse(_pesoController.text);
                        double talla = double.parse(_tallaController.text);
                        DateTime fechaNacimiento = DateFormat('dd-MMM-yyyy').parse(_fechaNacimientoController.text);
                        int edad = DateTime.now().year - fechaNacimiento.year;

                        Provider.of<datosFormulario>(context, listen: false)
                            .updateIMC(peso, talla);
                        Provider.of<datosFormulario>(context, listen: false)
                            .updatePesoIdeal(talla, _sexo);
                        Provider.of<datosFormulario>(context, listen: false)
                            .updatePesoPredicho(talla, _sexo);
                        Provider.of<datosFormulario>(context, listen: false)
                            .updateVolemia(peso);
                        Provider.of<datosFormulario>(context, listen: false)
                            .updateEdad(edad);
                            
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => antecedentesPersonales())
                        );
                      }
                    },
                    child: Text('Calcular'),
                  ),
                ),
                SizedBox(height: 16.0),
                Consumer<datosFormulario>(
                  builder: (context, calculos, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('IMC: ${calculos.imc}'),
                        Text('Peso Ideal: ${calculos.pesoIdeal}'),
                        Text('Peso Predicho: ${calculos.pesoPredicho}'),
                        Text('Volemia: ${calculos.volemia} ml'),
                        Text('Edad: ${calculos.edad} años')
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
