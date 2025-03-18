import 'dart:math';

class CalculosApp{

  // Funciones para calcular los valores de los indicadores

  static double calcularIMC(double peso, double altura){
    return peso / (altura * altura);
  }

  // En este calculo, la altura debe ir en metros
  static double calcularPesoIdeal(double altura, String sexo){
    double varPeso = sexo == "Masculino" ? 23 : 21.5;
    return varPeso * (altura * altura);
  }

  // En este calculo, la altura debe ir en cm
  static double calcularPesoPredicho(double altura, String sexo) {
    double pesoBase = sexo == "Masculino" ? 50 : 45.5;
    return pesoBase + 0.91 * ((altura*100) - 152.4);
  }

  static double calcularVolemia(double peso){
    return peso * 70;
  }

  // Calculo de perdidas permisibles, en la variable tasa se ingresará el porcentaje de perdida (ejemplo: 0.1 para 10% de perdida)
  static List<double> perdidasPermisibles(double hemoglobina, double volemia) {
    List<double> perdidas = [];

    double tasa10 = 0.10;
    double hemoglobinaReducida10 = hemoglobina - (hemoglobina * tasa10);
    double cambioHb10 = hemoglobina - hemoglobinaReducida10;
    double promedio10 = (hemoglobina + hemoglobinaReducida10) / 2;
    double volumenPerdido10 = (cambioHb10 / promedio10) * volemia;
    perdidas.add(volumenPerdido10);

    double tasa20 = 0.20;
    double hemoglobinaReducida20 = hemoglobina - (hemoglobina * tasa20);
    double cambioHb20 = hemoglobina - hemoglobinaReducida20;
    double promedio20 = (hemoglobina + hemoglobinaReducida20) / 2;
    double volumenPerdido20 = (cambioHb20 / promedio20) * volemia;
    perdidas.add(volumenPerdido20);

    double tasa30 = 0.30;
    double hemoglobinaReducida30 = hemoglobina - (hemoglobina * tasa30);
    double cambioHb30 = hemoglobina - hemoglobinaReducida30;
    double promedio30 = (hemoglobina + hemoglobinaReducida30) / 2;
    double volumenPerdido30 = (cambioHb30 / promedio30) * volemia;
    perdidas.add(volumenPerdido30);

    return perdidas;
  }

  static double tasaDeFiltracionGlomerular(int edad, double? creatinina, double peso, String sexo) {
    if (creatinina == 0) {
      return 0;
    }
    double resultado = ((140 - edad) * peso )/ (72 * creatinina!);
    if (sexo == "Femenino") {
      resultado *= 0.85;
    }
    return resultado;
  }

  static double indiceDePaquetesAnual(int cigarrillos, int anual){
    return cigarrillos * anual / 20;
  }

  static double calcularToracoscore(double coeficiente){
    double euler = 2.71828;
    double constante = 7.3737;
    double logit = coeficiente - constante;

    return (pow(euler, logit) / (1 + pow(euler, logit))) * 100;
  }
}
