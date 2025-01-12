import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/Screens/antecedentesPersonales.dart';
import 'package:app_medica/vistas/Screens/tipoDeCirugia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class datosPersonales extends StatefulWidget {
  datosPersonales({super.key});

  @override
  _datosPersonalesState createState() => _datosPersonalesState();
}

class _datosPersonalesState extends State<datosPersonales> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  String? _sexo;
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _tallaController = TextEditingController();
  bool _useDateOfBirth = true;
  final TextEditingController _edadController = TextEditingController();

  final RegExp _onlyLetters = RegExp(r'^[a-zA-ZÁÉÍÓÚáéíóúÑñ ]+$');
  final RegExp _onlyNumbers = RegExp(r'^[0-9.]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos Personales'),
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
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }else if (!_onlyLetters.hasMatch(value)) {
                      return 'Por favor ingresa un nombre válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                SwitchListTile(
                  title: const Text('Usar fecha de nacimiento'),
                  value: _useDateOfBirth,
                  onChanged: (bool value) {
                    setState(() {
                      _useDateOfBirth = value;
                      _fechaNacimientoController.clear();
                      _edadController.clear();
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                if (_useDateOfBirth)
                  TextFormField(
                    controller: _fechaNacimientoController,
                    decoration: const InputDecoration(labelText: 'Fecha de Nacimiento'),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor selecciona una fecha de nacimiento';
                      }
                      return null;
                    },
                  )
                else
                  TextFormField(
                    controller: _edadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Edad'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingresa la edad';
                      } else if (!_onlyNumbers.hasMatch(value)) {
                        return 'Por favor ingresa una edad válida';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: _sexo,
                  onChanged: (value) {
                  setState(() {
                    _sexo = value!;
                  });
                  },
                  items: ['Masculino', 'Femenino']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                  }).toList(),
                  decoration: const InputDecoration(
                  labelText: 'Sexo',
                  hintText: 'Selecciona tu sexo',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _pesoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Peso (kg)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa el peso';
                    }else if (!_onlyNumbers.hasMatch(value)) {
                      return 'Por favor ingresa un peso válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _tallaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Talla (m)'),
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
                        String nombre = _nombreController.text;
                        double peso = double.parse(_pesoController.text);
                        double talla = double.parse(_tallaController.text);
                        int edad;
                        if (_useDateOfBirth) {
                          DateTime fechaNacimiento = DateFormat('dd-MMM-yyyy').parse(_fechaNacimientoController.text);
                          edad = DateTime.now().year - fechaNacimiento.year;
                          if (DateTime.now().month < fechaNacimiento.month || 
                            (DateTime.now().month == fechaNacimiento.month && DateTime.now().day < fechaNacimiento.day)) {
                            edad--;
                          }
                          Provider.of<datosFormulario>(context, listen: false)
                              .updatefechaNacimiento(fechaNacimiento);
                        } else {
                          edad = int.parse(_edadController.text);
                        }

                        Provider.of<datosFormulario>(context,listen: false)
                            .updateNombre(nombre);
                        Provider.of<datosFormulario>(context,listen: false)
                            .updatePeso(peso);
                        Provider.of<datosFormulario>(context,listen: false)
                            .updateSexo(_sexo!);
                        Provider.of<datosFormulario>(context,listen: false)
                            .updateAltura(talla);
                        Provider.of<datosFormulario>(context, listen: false)
                            .updateIMC(peso, talla);
                        Provider.of<datosFormulario>(context, listen: false)
                            .updatePesoIdeal(talla, _sexo!);
                        Provider.of<datosFormulario>(context, listen: false)
                            .updatePesoPredicho(talla, _sexo!);
                        Provider.of<datosFormulario>(context, listen: false)
                            .updateVolemia(peso);
                        Provider.of<datosFormulario>(context, listen: false)
                            .updateEdad(edad);

                            

                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => antecedentesPersonales())
                            );
                    
                      }
                    },
                    child: const Text('Calcular'),
                  ),
                ),
           
              ],
            ),
          ),
        ),
      ),
    );
  }
}
