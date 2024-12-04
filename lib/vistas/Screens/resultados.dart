import 'package:app_medica/calculos/datosFormulario.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class resultados {
  static Future<File> generarDocumento(datosFormulario datos) async {
    String clasificacionIMC(double imc) {
      if (imc < 18.5) return 'Bajo Peso';
      if (imc < 25) return 'Normopeso';
      if (imc < 30) return 'Sobrepeso';
      if (imc < 35) return 'Obesidad tipo 1';
      if (imc < 40) return 'Obesidad tipo 2';
      if (imc < 50) return 'Obesidad tipo 3 o mórbida';
      return 'Obesidad tipo 4 o extrema';
    }
    
    String clasificacionASA(int asa) {
      if (asa == 1) return 'Saludable';
      if (asa == 2) return 'Enfermedad sistémica leve';
      if (asa == 3) return 'Enfermedad sistémica grave que limita las actividades';
      if (asa == 4) return 'Enfermedad sistémica grave que constituye una constante amenaza a la vida';
      if (asa == 5) return 'Moribundo, no se espera que sobreviva sin una intervención quirúrgica.';
      if (asa == 6) return 'Con muerte cerebral';
      return '';
    }


    final pdf = pw.Document();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(datos.fechaNacimiento);


    pdf.addPage(pw.MultiPage(build: (pw.Context context) {
      return <pw.Widget>[
        pw.Text('Datos Personales',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        pw.Text('Nombre: ${datos.nombre}'),
        pw.Text('fecha de Nacimiento: $formattedDate'),
        pw.Text('Edad: ${datos.edad}Años.'),
        pw.Text('Talla: ${datos.altura}Mts.'),
        pw.Text('Peso real: ${datos.peso}Kg.'),
        pw.Text('Peso ideal: ${datos.pesoIdeal.toStringAsFixed(2)}Kg.'),
        pw.Text('Peso predicho: ${datos.pesoPredicho.toStringAsFixed(2)}Kg.'),
        pw.Text('IMC: ${clasificacionIMC(datos.imc)}'),
        pw.Text('Volemia: ${datos.volemia.toStringAsFixed(3)}ml.'),
        pw.Text(
            'Tasa de filtración glomerular: ${datos.tasaFiltracionGlomerular.toStringAsFixed(4)} ml/min.'),

        pw.SizedBox(height: 20),

        pw.Text('Antecedentes Personales',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        if (datos.patologias.isNotEmpty) pw.Text('Patológicas: ${datos.patologias.join(', ')}'),
        if (datos.quirurgicos.isNotEmpty) pw.Text('Quirúrgicos: ${datos.quirurgicos.join(', ')}'),
        if (datos.anestesicos.isNotEmpty) pw.Text('Anestésicos: ${datos.anestesicos.join(', ')}'),
        if (datos.complicaciones.isNotEmpty) pw.Text('Complicaciones: ${datos.complicaciones.join(', ')}'),
        if (datos.alergicos.isNotEmpty) pw.Text('Alergias: ${datos.alergicos.join(', ')}', style: pw.TextStyle(color: PdfColors.red)),
        if (datos.toxicos.isNotEmpty) pw.Text('Tóxicos: ${datos.toxicos.join(', ')}'),
        if (datos.transfusion.isNotEmpty) pw.Text('Transfusiones: ${datos.transfusion.join(', ')}'),

        pw.SizedBox(height: 20),

        pw.SizedBox(height: 20),

        //aqui va el estado físico

        pw.SizedBox(height: 20),

        pw.Text('Paraclínicos',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        if (datos.leucocitos != null) pw.Text('Leucocitos: ${datos.leucocitos}'),
        if (datos.neutrofilos != null) pw.Text('Neutrófilos: ${datos.neutrofilos}'),
        if (datos.linfocitos != null) pw.Text('Linfocitos: ${datos.linfocitos}'),
        if (datos.hematocrito != null) pw.Text('Hematocrito: ${datos.hematocrito}'),
        if (datos.plaquetas != null) pw.Text('Plaquetas: ${datos.plaquetas}'),
        if (datos.bun != null) pw.Text('BUN: ${datos.bun}'),
        if (datos.creatinina != null) pw.Text('Creatinina: ${datos.creatinina}'),
        if (datos.glicemia != null) pw.Text('Glicemia: ${datos.glicemia}'),
        if (datos.hba1c != null) pw.Text('HbA1C: ${datos.hba1c}'),
        if (datos.tp != null) pw.Text('TP: ${datos.tp}'),
        if (datos.tpt != null) pw.Text('TPT: ${datos.tpt}'),
        if (datos.sodio != null) pw.Text('Sodio: ${datos.sodio}'),
        if (datos.potasio != null) pw.Text('Potasio: ${datos.potasio}'),
        if (datos.cloro != null) pw.Text('Cloro: ${datos.cloro}'),
        if (datos.gasesArteriales != null) pw.Text('Gases Arteriales: ${datos.gasesArteriales}'),
        if (datos.otros != null) pw.Text('Otros: ${datos.otros ?? 'No hay datos'}'),

        pw.Text('Pérdidas Permisibles',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        pw.Text('Hemoglobina: ${datos.hemoglobina}'),
        if (datos.hemoglobina <= 8)
          pw.Bullet(text: 'No tiene pérdidas permisibles')
        else
          for (var i = 0; i < datos.perdidasPermisibles.length; i++)
            pw.Bullet(
                text: '${[
              10,
              20,
              30
            ][i]}% de pérdidas sanguíneas permisibles: ${(datos.perdidasPermisibles[i]/1000).toStringAsFixed(2)}ml'),

        pw.SizedBox(height: 20),

        pw.Text('Ayudas Diagnósticas',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        if (datos.ekg != null) pw.Bullet(text: datos.ekg),
        if (datos.ecocardiograma != null) pw.Bullet(text: datos.ecocardiograma),
        if (datos.rxTorax != null) pw.Bullet(text: datos.rxTorax),
        if (datos.otroAyudaDiagnostica != null) pw.Bullet(text: datos.otroAyudaDiagnostica),

        pw.SizedBox(height: 20),

        pw.Text('clasificación ASA',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        pw.Text('ASA: ${datos.asa}'),
        pw.Text('Clasificación: ${clasificacionASA(datos.asa)}'),

        pw.SizedBox(height: 20),
        pw.Text('Tipo de Cirugía: ${datos.selectedSurgery}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
         for (var i = 0; i < datos.scaleValues.length; i++)
          pw.Bullet(
            text: datos.scaleValues.keys.elementAt(i) == 'Escala de ToracoScore'
                ? '${datos.scaleValues.keys.elementAt(i)}: ${datos.scaleValues.values.elementAt(i)} - Probabilidad de Muerte Hospitalaria: ${datos.probMuerteHospitalaria.toStringAsFixed(1)}%'
                : '${datos.scaleValues.keys.elementAt(i)}: ${datos.scaleValues.values.elementAt(i)}',
          ),
        pw.SizedBox(height: 20),

        pw.Text('Examen Físico',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        for (var i = 0; i < datos.examenFisico.length; i++)
          pw.Bullet(
              text:
                  '${datos.examenFisico.keys.elementAt(i)}: ${datos.examenFisico.values.elementAt(i)}'),

        pw.SizedBox(height: 20),

        pw.Text('Plan Anestésico',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        for (var i = 0; i < datos.selectedOptions.length; i++)
          pw.Bullet(text: datos.selectedOptions[i]),
        pw.Bullet(text: datos.freeText),
      ];
    }));

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/datos_medicos_${datos.nombre}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
