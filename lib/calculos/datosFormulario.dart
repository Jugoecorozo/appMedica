import 'package:app_medica/calculos/calculosApp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class datosFormulario with ChangeNotifier{

  // Estos son los datos que se mostrarán en la pantalla de resultados
  double imc = 0;
  double pesoIdeal = 0;
  double pesoPredicho = 0;
  double volemia = 0;
  double perdidasPermisibles = 0;
  double tasaFiltracionGlomerular = 0;

  int edad = 0;

  // Getters para obtener los valores de los indicadores
  double get getIMC => imc;
  double get getPesoIdeal => pesoIdeal;
  double get getPesoPredicho => pesoPredicho;
  double get getVolemia => volemia;
  double get getPerdidasPermisibles => perdidasPermisibles;
  double get getTasaFiltracionGlomerular => tasaFiltracionGlomerular;
  int get getEdad => edad;

   // Métodos para actualizar los cálculos
  void updateIMC(double peso, double altura) {
    imc = CalculosApp.calcularIMC(peso, altura);
    notifyListeners();
  }

  void updatePesoIdeal(double altura, String sexo) {
    pesoIdeal = CalculosApp.calcularPesoIdeal(altura, sexo);
    notifyListeners();
  }

  void updatePesoPredicho(double altura, String sexo) {
    pesoPredicho = CalculosApp.calcularPesoPredicho(altura, sexo);
    notifyListeners();
  }

  void updateVolemia(double peso) {
    volemia = CalculosApp.calcularVolemia(peso);
    notifyListeners();
  }

  void updatePerdidasPermisibles(double hemoglobina, double tasa) {
    perdidasPermisibles = CalculosApp.perdidasPermisibles(hemoglobina, volemia, tasa);
    notifyListeners();
  }

  void updateTasaFiltracionGlomerular(double edad, double creatinina, double peso) {
    tasaFiltracionGlomerular = CalculosApp.tasaDeFiltracionGlomerular(edad, creatinina, peso);
    notifyListeners();
  }

  void updateEdad(int edad) {
    this.edad = edad;
    notifyListeners();
  }
  
}