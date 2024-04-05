
import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class paraclinicos extends StatefulWidget {
  const paraclinicos({super.key});

  @override
  State<paraclinicos> createState() => _paraclinicosState();
}

class _paraclinicosState extends State<paraclinicos> {

  double? hemoglobina1;
  double? hemoglobina2;
  double? hemoglobina3;

  Widget _buildNumericField(String label) {
    return Row(
      children: [
        Expanded(
          child: Text(label),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 100,
          child: TextFormField(
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label) {
    return Row(
      children: [
        Expanded(
          child: Text(label),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 100,
          child: TextFormField(),
        ),
      ],
    );
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paraclínicos y Ayudas Diagnósticas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PARACLÍNICOS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildNumericField('Leucocitos'),
              _buildNumericField('Neutrófilos'),
              _buildNumericField('Linfocitos'),
              _buildNumericField('Hemoglobina'),
              _buildNumericField('Hematocrito'),
              _buildNumericField('Plaquetas'),
              _buildNumericField('Bun'),
              _buildNumericField('Creatinina'),
              _buildNumericField('Glicemia'),
              _buildNumericField('HbA1C'),
              _buildNumericField('TP'),
              _buildNumericField('TPT'),
              _buildNumericField('Sodio'),
              _buildNumericField('Potasio'),
              _buildNumericField('Cloro'),
              _buildNumericField('Gases Arteriales'),
              _buildNumericField('Otros'),
              SizedBox(height: 20),
              Text(
                'AYUDAS DIAGNOSTICAS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildTextField('EKG'),
              _buildTextField('Ecocardiograma'),
              _buildTextField('Rx de tórax'),
              _buildTextField('Otro'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Provider.of<datosFormulario>(context, listen: false)
                      .updatePerdidasPermisibles(0.1, 1);
                  Provider.of<datosFormulario>(context, listen: false)
                      .updatePerdidasPermisibles(0.2, 2);
                  Provider.of<datosFormulario>(context, listen: false)
                      .updatePerdidasPermisibles(0.3, 3);
                },
                child: Text('Guardar'),
              ),
              Consumer<datosFormulario>(
                  builder: (context, calculos, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('IMC: ${calculos.perdidasPermisibles}'),
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
}