import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:app_medica/vistas/Screens/planAnestesico.dart';
import 'package:app_medica/vistas/Screens/tipoDeCirugia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParaclinicosWidget extends StatelessWidget {
  const ParaclinicosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paraclínicos y Ayudas Diagnósticas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PARACLÍNICOS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildNumericField(context, 'Leucocitos'),
              _buildNumericField(context, 'Neutrófilos'),
              _buildNumericField(context, 'Linfocitos'),
              _buildNumericField(context, 'Hemoglobina'),
              _buildNumericField(context, 'Hematocrito'),
              _buildNumericField(context, 'Plaquetas'),
              _buildNumericField(context, 'Bun'),
              _buildNumericField(context, 'Creatinina'),
              _buildNumericField(context, 'Glicemia'),
              _buildNumericField(context, 'HbA1C'),
              _buildNumericField(context, 'TP'),
              _buildNumericField(context, 'TPT'),
              _buildNumericField(context, 'Sodio'),
              _buildNumericField(context, 'Potasio'),
              _buildNumericField(context, 'Cloro'),
              _buildNumericField(context, 'Gases Arteriales'),
              _buildTextField(context, 'Otros'),
              const SizedBox(height: 20),
              const Text(
                'AYUDAS DIAGNOSTICAS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField(context, 'EKG'),
              _buildTextField(context, 'Ecocardiograma'),
              _buildTextField(context, 'Rx de tórax'),
              _buildTextField(context, 'Otro'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveData(context);
                },
                child: const Text('Guardar'),
              ),
              Consumer<datosFormulario>(
                builder: (context, calculos, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PERDIDAS : ${calculos.perdidasPermisibles}'),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData(BuildContext context) {
    var datos = Provider.of<datosFormulario>(context, listen: false);
    // Realizar acciones de guardar datos
    Provider.of<datosFormulario>(context, listen: false)
        .updatePerdidasPermisibles();
    String sexo = Provider.of<datosFormulario>(context, listen: false).sexo;
    Provider.of<datosFormulario>(context, listen: false)
        .updateTasaFiltracionGlomerular(
            datos.edad, datos.creatinina!, datos.peso, sexo);
    // Mostrar mensaje de confirmación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Datos guardados correctamente'),
      ),
    );

    // Navegar a la siguiente
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SurgeryRiskCalculator()),
    );
  }

  Widget _buildNumericField(BuildContext context, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        final double? numericValue = double.tryParse(value);
        switch (label) {
          case 'Leucocitos':
            Provider.of<datosFormulario>(context, listen: false).leucocitos = numericValue;
            break;
          case 'Neutrófilos':
            Provider.of<datosFormulario>(context, listen: false).neutrofilos = numericValue;
            break;
          case 'Linfocitos':
            Provider.of<datosFormulario>(context, listen: false).linfocitos = numericValue;
            break;
          case 'Hemoglobina':
            Provider.of<datosFormulario>(context, listen: false).hemoglobina = numericValue ?? 0;
            break;
          case 'Hematocrito':
            Provider.of<datosFormulario>(context, listen: false).hematocrito = numericValue;
            break;
          case 'Plaquetas':
            Provider.of<datosFormulario>(context, listen: false).plaquetas = numericValue;
            break;
          case 'Bun':
            Provider.of<datosFormulario>(context, listen: false).bun = numericValue;
            break;
          case 'Creatinina':
            Provider.of<datosFormulario>(context, listen: false).creatinina = numericValue ?? 0;
            break;
          case 'Glicemia':
            Provider.of<datosFormulario>(context, listen: false).glicemia = numericValue;
            break;
          case 'HbA1C':
            Provider.of<datosFormulario>(context, listen: false).hba1c = numericValue;
            break;
          case 'TP':
            Provider.of<datosFormulario>(context, listen: false).tp = numericValue;
            break;
          case 'TPT':
            Provider.of<datosFormulario>(context, listen: false).tpt = numericValue;
            break;
          case 'Sodio':
            Provider.of<datosFormulario>(context, listen: false).sodio = numericValue;
            break;
          case 'Potasio':
            Provider.of<datosFormulario>(context, listen: false).potasio = numericValue;
            break;
          case 'Cloro':
            Provider.of<datosFormulario>(context, listen: false).cloro = numericValue;
            break;
          case 'Gases Arteriales':
            Provider.of<datosFormulario>(context, listen: false).gasesArteriales = numericValue;
            break;
          default:
            break;
        }
      },
    );
  }

  Widget _buildTextField(BuildContext context, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onChanged: (value) {
        switch (label) {
          case 'Otros':
            Provider.of<datosFormulario>(context, listen: false).otros = value;
            break;
          case 'EKG':
            Provider.of<datosFormulario>(context, listen: false).ekg = value;
            break;
          case 'Ecocardiograma':
            Provider.of<datosFormulario>(context, listen: false).ecocardiograma = value;
            break;
          case 'Rx de tórax':
            Provider.of<datosFormulario>(context, listen: false).rxTorax = value;
            break;
          case 'Otro':
            Provider.of<datosFormulario>(context, listen: false).otroAyudaDiagnostica = value;
            break;
          default:
            break;
        }
      },
    );
  }
}
