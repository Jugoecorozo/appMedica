import 'package:flutter/material.dart';

class GlanceScaleWidget extends StatefulWidget {
  final void Function(String, String) onValueUpdated;
  const GlanceScaleWidget({super.key, required this.onValueUpdated});

  @override
  _GlanceScaleWidgetState createState() => _GlanceScaleWidgetState();
}

class _GlanceScaleWidgetState extends State<GlanceScaleWidget> {
  int selectedCellIndex = -1;

  void updateTextField(String value) {
    setState(() {
      widget.onValueUpdated('ESCALA DE GLANCE', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escala De Glance',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataRowMaxHeight: double.infinity,
            columns: const [
              DataColumn(label: Text('RIESGO BAJO (<1%)')),
              DataColumn(label: Text('RIESGO INTERMEDIO  (1-5%)')),
              DataColumn(label: Text('RIESGO ALTO (>5%)')),
            ],
            rows: [
              DataRow(cells: [
                buildDataCell(
                  'Riesgo quirúrgico bajo',
                  '- Cirugía superficial\n- Cirugía de mama\n- Odontología\n- Tiroides\n- Ojo\n- Reconstructiva\n- Carotídea en pacientes asintomáticos (endarterectomía o STENT carotídeo)\n- Ginecológica menor\n- Ortopédica menor (meniscectomía)\n- Urológica menor (Resección transuretral de próstata)',
                  0,
                ),
                buildDataCell(
                  'Riesgo quirúrgico intermedio',
                  '- Intraperitoneal (esplenectomía, reparación de hernia hiatal, colecistectomía)\n- Carotídea en pacientes sintomáticos (endarterectomía o STENT carotídeo)\n- Angioplastia arterial periférica\n- Reparación endovascular de aneurisma\n- Cirugía de cabeza y cuello\n- Neurocirugía\n- Ortopedia mayor (cadera, columna)\n- Ginecológica mayor\n- Urológica mayor\n- Trasplante renal\n- Intratorácica (no mayor)',
                  1,
                ),
                buildDataCell(
                  'Riesgo quirúrgico alto',
                  '- Cirugía aortica y vascular mayor\n- Cirugía pancreática-duodenal\n- Revascularización abierta de miembros inferiores o amputación o troboembolectomía\n- Resección hepática o cirugía de la vía biliar\n- Esofagectomía\n- Reparación de perforación intestinal\n- Resección adrenal\n- Cistectomía total\n- Neumonectomía\n- Trasplante hepático\n- Trasplante pulmonar',
                  2,
                ),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  DataCell buildDataCell(String title, String content, int index) {
    final isSelected = selectedCellIndex == index;

    return DataCell(
      GestureDetector(
        onTap: () {
          setState(() {
            selectedCellIndex = index;
          });
          updateTextField(title);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.withOpacity(0.2)
                : null, // Cambia el color de fondo si está seleccionado
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(8.0),
          width: 300,
          child: Text(
            content,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}