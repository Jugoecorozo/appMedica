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

  //Calculo de perdidas permisibles, en la variable tasa se ingresará el porcentaje de perdida (ejemplo: 0.1 para 10% de perdida)
  static List<double> perdidasPermisibles(double hemoglobina, double volemia) {
    List<double> tasas = [0.1, 0.2, 0.3];
    return tasas.map((tasa) => ((hemoglobina - (hemoglobina * tasa)) / (hemoglobina + ((hemoglobina * tasa) / 2))) * volemia).toList();
  }


  static double tasaDeFiltracionGlomerular(int edad, double creatinina, double peso, String sexo) {
    double resultado = ((140 - edad) * peso )/ (72 * creatinina);
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