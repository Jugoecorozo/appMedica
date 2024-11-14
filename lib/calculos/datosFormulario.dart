import 'package:app_medica/calculos/calculosApp.dart';
import 'package:flutter/material.dart';

class datosFormulario with ChangeNotifier {
  // Propiedades relacionadas con los datos del paciente
  String nombre = '';
  DateTime fechaNacimiento = DateTime.now();
  String sexo = '';
  int edad = 0;
  double peso = 0;
  double altura = 0;
  double imc = 0;
  double pesoIdeal = 0;
  double pesoPredicho = 0;
  double volemia = 0;
  double tasaFiltracionGlomerular = 0;
  double ipa = 0;
  double hemoglobina = 0;

  // Propiedades relacionadas con los resultados y cálculos
  List<double> perdidasPermisibles = [];
 
  
  // Propiedades relacionadas con exámenes y diagnósticos
  double? leucocitos;
  double? neutrofilos;
  double? linfocitos;
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

  // Listas de condiciones y antecedentes
  List<String> patologias = [];
  List<String> quirurgicos = [];
  List<String> anestesicos = [];
  List<String> complicaciones = [];
  List<String> alergicos = [];
  List<String> toxicos = [];
  List<String> transfusion = [];

  // Propiedades relacionadas con la cirugía y el plan anestésico
  String? selectedSurgery;
  Map<String, String> scaleValues = {};
  List<String> selectedOptions = [];
  Map<String, String> examenFisico = {};
  String freeText = '';



  // Métodos de actualización de datos
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

  void updateTasaFiltracionGlomerular(int edad, double creatinina, double peso, String sexo) {
    tasaFiltracionGlomerular = CalculosApp.tasaDeFiltracionGlomerular(edad, creatinina, peso, sexo);
    notifyListeners();
  }

  void updatefechaNacimiento(DateTime fechaNacimiento) {
    this.fechaNacimiento = fechaNacimiento;
    notifyListeners();
  }

  void updateEdad(int edad) {
    this.edad = edad;
    notifyListeners();
  }

  void updateSexo(String sexo) {
    this.sexo = sexo;
    notifyListeners();
  }

  void updatePeso(double peso) {
    this.peso = peso;
    notifyListeners();
  }

  void updateAltura(double altura) {
    this.altura = altura;
    notifyListeners();
  }

  void updateNombre(String nombre) {
    this.nombre = nombre;
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

  void setSelectedSurgery(String? selectedSurgery) {
    this.selectedSurgery = selectedSurgery;
    notifyListeners();
  }

  void setScaleValues(Map<String, String> scaleValues) {
    this.scaleValues = scaleValues;
    notifyListeners();
  }

  void setSelectedOptions(List<String> selectedOptions) {
    this.selectedOptions = selectedOptions;
    notifyListeners();
  }

  void setExamenFisico(Map<String, String> examenFisico) {
    this.examenFisico = examenFisico;
    notifyListeners();
  }
  
  void setFreeText(String freeText) {
    this.freeText = freeText;
    notifyListeners();
  }
}
