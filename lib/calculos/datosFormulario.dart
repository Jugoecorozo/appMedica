
import 'package:app_medica/calculos/calculosApp.dart';
import 'package:flutter/material.dart';

class datosFormulario with ChangeNotifier{

  // Estos son los datos que se mostrarán en la pantalla de resultados
  double imc = 0;
  double pesoIdeal = 0;
  double pesoPredicho = 0;
  double volemia = 0;
  List<double> perdidasPermisibles = [];
  double perdidasPermisibles20 = 0;
  double perdidasPermisibles30 = 0;
  double tasaFiltracionGlomerular = 0;
  double ipa = 0;
  int edad = 0; 

  List<String> patologias = [];
  List<String> quirurgicos = [];
  List<String> anestesicos = [];
  List<String> complicaciones = [];
  List<String> alergicos = [];
  List<String> toxicos = [];
  List<String> transfusion = [];

  double? leucocitos;
  double? neutrofilos;
  double? linfocitos;
  double hemoglobina = 0;
  double? hematocrito;
  double? plaquetas;
  double? bun;
  double? creatinina;
  double? glicemia;
  double? hba1c;
  double? tp;
  double? tpt;
  double? sodio;
  double? potasio;
  double? cloro;
  double? gasesArteriales;
  String? otros;

  String? ekg;
  String? ecocardiograma;
  String? rxTorax;
  String? otroAyudaDiagnostica;

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

  void updatePerdidasPermisibles() {
    perdidasPermisibles = CalculosApp.perdidasPermisibles(hemoglobina, volemia);
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

  void updateIPA(int cigarrillos, int anual) {
    ipa = CalculosApp.indiceDePaquetesAnual(cigarrillos, anual);
    notifyListeners();
  }

  void updatePatologias(List<String> patologias) {
    this.patologias = patologias;
    notifyListeners();
  }

  void updateQuirurgicos(List<String> quirurgicos) {
    this.quirurgicos = quirurgicos;
    notifyListeners();
  }

  void updateAnestesicos(List<String> anestesicos) {
    this.anestesicos = anestesicos;
    notifyListeners();
  }

  void updateComplicaciones(List<String> complicaciones) {
    this.complicaciones = complicaciones;
    notifyListeners();
  }

  void updateAlergicos(List<String> alergicos) {
    this.alergicos = alergicos;
    notifyListeners();
  }

  void updateToxicos(List<String> toxicos) {
    this.toxicos = toxicos;
    notifyListeners();
  }
  
  void updateTransfusion(List<String> transfusion) {
    this.transfusion = transfusion;
    notifyListeners();
  }
}