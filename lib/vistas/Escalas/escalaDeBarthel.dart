import 'package:flutter/material.dart';

class BarthelForm extends StatefulWidget {
  final void Function(String, String) onValueUpdated;

  const BarthelForm({super.key, required this.onValueUpdated});

  @override
  _BarthelFormState createState() => _BarthelFormState();
}

class _BarthelFormState extends State<BarthelForm> {
  Map<String, int?> activityPoints = {};


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Escala de Barthel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          _buildActivityRow(
              "Comer", ["Independiente", "Necesita ayuda", "Dependiente"], [10, 5, 0]),
          _buildActivityRow(
              "Lavarse", ["Independiente", "Dependiente"], [5, 0]),
          _buildActivityRow(
              "Vestirse", ["Independiente", "Necesita ayuda", "Dependiente"], [10, 5, 0]),
          _buildActivityRow(
              "Arreglarse", ["Independiente", "Dependiente"], [5, 0]),
          _buildActivityRow("Deposición", ["Continente", "Ocasional", "Incontinente"], [10, 5, 0]),
          _buildActivityRow("Micción", ["Continente", "Ocasional", "Incontinente"], [10, 5, 0]),
          _buildActivityRow(
              "Uso retrete", ["Independiente", "Necesita ayuda", "Dependiente"], [10, 5, 0]),
          _buildActivityRow(
              "Trasladarse (sillón/cama)",
              ["Independiente", "Mínima ayuda", "Necesita gran ayuda", "Dependiente"],
              [15, 10, 5, 0]),
          _buildActivityRow(
              "Deambular",
              ["Independiente", "Necesita ayuda", "Independiente en silla", "Dependiente"],
              [15, 10, 5, 0]),
          _buildActivityRow(
              "Subir escalera", ["Independiente", "Necesita ayuda", "Dependiente"], [10, 5, 0]),
        
        ],
      ),
    );
  }

 Widget _buildActivityRow(String activity, List<String> options, List<int> points) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(activity, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(options[index]),
            value: activityPoints[activity] == points[index],
            onChanged: (value) {
              setState(() {
                if (value!) {
                  activityPoints[activity] = points[index];
                } else {
                  activityPoints[activity] = null;
                }
              });

              // Calcular el puntaje total
              int totalPoints = 0;
              activityPoints.forEach((activity, points) {
                if (points != null) {
                  totalPoints += points;
                }
              });

              // Obtener la clasificación
              String classification = _getClassification(totalPoints);

              // Llamar a onValueUpdated con el puntaje total y la clasificación
              widget.onValueUpdated("ESCALA DE BARTHEL", "$totalPoints $classification");
            },
          );
        },
      ),
      const Divider(),
    ],
  );
}


  String _getClassification(int points) {
    if (points >= 0 && points <= 20) {
      return "Dependencia total";
    } else if (points >= 21 && points <= 60) {
      return "Dependencia severa";
    } else if (points >= 61 && points <= 90) {
      return "Dependencia moderada";
    } else if (points >= 91 && points <= 99) {
      return "Dependencia leve";
    } else {
      return "Independiente";
    }
  }
}