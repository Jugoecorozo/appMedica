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
        buildCheckboxListTile(
          'Riesgo quirúrgico bajo \n',
          '- Cirugía superficial\n- Cirugía de mama\n- Odontología\n- Tiroides\n- Ojo\n- Reconstructiva\n- Carotídea en pacientes asintomáticos (endarterectomía o STENT carotídeo)\n- Ginecológica menor\n- Ortopédica menor (meniscectomía)\n- Urológica menor (Resección transuretral de próstata)',
          0,
        ),
        buildCheckboxListTile(
          'Riesgo quirúrgico intermedio \n',
          '- Intraperitoneal (esplenectomía, reparación de hernia hiatal, colecistectomía)\n- Carotídea en pacientes sintomáticos (endarterectomía o STENT carotídeo)\n- Angioplastia arterial periférica\n- Reparación endovascular de aneurisma\n- Cirugía de cabeza y cuello\n- Neurocirugía\n- Ortopedia mayor (cadera, columna)\n- Ginecológica mayor\n- Urológica mayor\n- Trasplante renal\n- Intratorácica (no mayor)',
          1,
        ),
        buildCheckboxListTile(
          'Riesgo quirúrgico alto \n',
          '- Cirugía aortica y vascular mayor\n- Cirugía pancreática-duodenal\n- Revascularización abierta de miembros inferiores o amputación o troboembolectomía\n- Resección hepática o cirugía de la vía biliar\n- Esofagectomía\n- Reparación de perforación intestinal\n- Resección adrenal\n- Cistectomía total\n- Neumonectomía\n- Trasplante hepático\n- Trasplante pulmonar',
          2,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  CheckboxListTile buildCheckboxListTile(String title, String content, int index) {
    final isSelected = selectedCellIndex == index;

    return CheckboxListTile(
      title: Text(title),
      subtitle: Text(content),
      value: isSelected,
      onChanged: (bool? value) {
        setState(() {
          selectedCellIndex = value! ? index : -1;
        });
        updateTextField(title);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}