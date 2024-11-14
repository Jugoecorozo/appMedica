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
        pw.Text('Patológicas: ${datos.patologias.join(', ')}'),
        pw.Text('Quirúrgicos: ${datos.quirurgicos.join(', ')}'),
        pw.Text('Anestésicos: ${datos.anestesicos.join(', ')}'),
        pw.Text('Complicaciones: ${datos.complicaciones.join(', ')}'),
        pw.Text('Alergias: ${datos.alergicos.join(', ')}',
            style: pw.TextStyle(color: PdfColors.red)),
        pw.Text('Tóxicos: ${datos.toxicos.join(', ')}'),
        pw.Text('Transfusiones: ${datos.transfusion.join(', ')}'),

        pw.SizedBox(height: 20),

        pw.SizedBox(height: 20),

        //aqui va el estado físico

        pw.SizedBox(height: 20),

        pw.Text('Paraclínicos',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        pw.Text('Leucocitos: ${datos.leucocitos}'),
        pw.Text('Neutrófilos: ${datos.neutrofilos}'),
        pw.Text('Linfocitos: ${datos.linfocitos}'),
        pw.Text('Hematocrito: ${datos.hematocrito}'),
        pw.Text('Plaquetas: ${datos.plaquetas}'),
        pw.Text('BUN: ${datos.bun}'),
        pw.Text('Creatinina: ${datos.creatinina}'),
        pw.Text('Glicemia: ${datos.glicemia}'),
        pw.Text('HbA1C: ${datos.hba1c}'),
        pw.Text('TP: ${datos.tp}'),
        pw.Text('TPT: ${datos.tpt}'),
        pw.Text('Sodio: ${datos.sodio}'),
        pw.Text('Potasio: ${datos.potasio}'),
        pw.Text('Cloro: ${datos.cloro}'),
        pw.Text('Gases Arteriales: ${datos.gasesArteriales}'),
        pw.Text('Otros: ${datos.otros ?? 'No hay datos'}'),

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
        pw.Bullet(text: datos.ekg ?? 'EKG no disponible'),
        pw.Bullet(text: datos.ecocardiograma ?? 'Ecocardiograma no disponible'),
        pw.Bullet(text: datos.rxTorax ?? 'Rx de tórax no disponible'),
        pw.Bullet(
            text: datos.otroAyudaDiagnostica ??
                'Otra ayuda diagnóstica no disponible'),

        pw.SizedBox(height: 20),
        pw.Text('Tipo de Cirugía: ${datos.selectedSurgery}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1.0, color: PdfColors.black),
        for (var i = 0; i < datos.scaleValues.length; i++)
          pw.Bullet(
              text:
                  '${datos.scaleValues.keys.elementAt(i)}: ${datos.scaleValues.values.elementAt(i)}'),

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
