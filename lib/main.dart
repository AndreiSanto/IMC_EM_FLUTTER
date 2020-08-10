import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";
  void _resetFildes() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  bool validacao(String validar) {
    int i;
    int cont = 0;
    for (i = 0; i < validar.length; i++) {
      if (validar[i].contains('.')) {
        cont = cont + 1;
      }
    }
    if (cont >= 2) {
      return true;
    } else {
      return false;
    }
    
  }
  double validarValor(String valor){
      double valo = double.parse(valor);
      return valo;
    }

  void _calculate() {
    setState(() {
      double peso = double.parse(weightController.text);
      double altura = double.parse(heightController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do Peso ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 30.0 && imc <= 34.9) {
        _infoText = "Obesidade grau I ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 35.0 && imc < 40) {
        _infoText = "Obesidade grau II (severa)${imc.toStringAsPrecision(4)}";
      } else {
        _infoText = "Obesidade III(mórbida) ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFildes,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // pra fazer a tela rolar se ela for muito grande
        padding: EdgeInsets.fromLTRB(
            10.0, 0.0, 10.0, 0.0), // definir o espaçamento dos lados
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso(kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  // maxLength: 4,
                  validator: (value) {
                    List<String> teste = value.split(".");
                    // double valor = double.parse(value);
                    if (value.isEmpty) {
                      return "Digite seu Peso";
                    } else if (teste[0].isEmpty || teste[0].contains('0')) {
                      return "Valor invalido";
                    } else if (validacao(value)) {
                      return "Valor invalido";
                    }else if(validarValor(value) < 0){
                        return "Valor invalido";

                    }
                  }),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Digite a sua Altura";
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //vai vericar se o formulario esta valido
                        _calculate();
                      }
                    },
                    child: Text("Calcular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        )),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                "$_infoText",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
