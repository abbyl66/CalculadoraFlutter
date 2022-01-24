import 'package:calculadora_flutter/botones.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Calculadora());
}

class Calculadora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Ejecuta el programa
      home: CalculadoraFlutter(),
    );
  }
}

class CalculadoraFlutter extends StatefulWidget {
  //Redirecciona funcionamiento.
  @override
  CalculadoraState createState() => CalculadoraState();
}

class CalculadoraState extends State<CalculadoraFlutter> {
  //Declaración de operaciones y resultados.
  var eOpc = '';
  var preAns = '';
  var operacion = '';
  var resultado = '';

  final textoEstilo = TextStyle(fontSize: 38, color: Colors.black);

  //Botones para GridView
  final List<String> botones = [
    'C',
    '⌫',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Diseño
      backgroundColor: Color(0xFFFEF3E9),                                                                                                                                       
      body: Column(
        children: <Widget>[
          
          Expanded(
            //Espacio donde se encuentran las operaciones y resultados.
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 40),
                  Container(
                      alignment: Alignment.centerRight, child: Text(eOpc, style: TextStyle(fontSize: 15, color: Colors.grey)), padding: EdgeInsets.only(right: 20),),
                  Container(
                      alignment: Alignment.centerRight, child: Text(operacion, style: TextStyle(fontSize: 23),), padding: EdgeInsets.all(20),),
                  Container(
                      alignment: Alignment.centerRight, child: Text(preAns, style: TextStyle(fontSize: 15),), padding: EdgeInsets.only(right: 20),),
                  Container(
                      alignment: Alignment.centerRight, child: Text(resultado, style: TextStyle(fontSize: 20),), padding: EdgeInsets.only(right: 20),)
                ],
              ),
            ),
          ),
          
          //Espacio donde están los botones,
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: botones.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    //Botón C, borrar todo.
                    if (index == 0) {
                      return Botones(
                          botonTap: (){
                            setState(() {
                              eOpc='';
                              operacion = '';
                              resultado='';
                              preAns='';
                            });
                          },
                          botonTxt: botones[index],
                          color: Color(0xFFE6D9D1),
                          ColorTxt: Color(0XFFFEF3E9));
                    } else if (index == 1) { //Botón para borrar un número.
                      return Botones(
                          botonTap: (){
                            setState(() {
                              operacion= operacion.substring(0, operacion.length-1);
                            });
                          },
                          botonTxt: botones[index],
                          color: Color(0xFFE6D9D1),
                          ColorTxt: Color(0XFFFEF3E9));
                    }else if (index == botones.length-1) { //Botón =, resultado final de la operación.
                      return Botones(
                          botonTap: (){
                            setState(() {
                              resultadOperacion();
                            });
                          },
                          botonTxt: botones[index],
                          color: Color(0xFFEACFBE),
                          ColorTxt: Color(0XFFFEF3E9));
                    }else if (index == botones.length-2) { //Botón ANS, preresultado de la operación.
                      return Botones(
                          botonTap: (){
                            setState(() {
                              preResultado();
                            });
                          },
                          botonTxt: botones[index],
                          color: Color(0xFFEACFBE),
                          ColorTxt: Color(0XFFFEF3E9));
                    }else { //Números en espacio de operación.
                      return Botones(
                          botonTap: (){
                            setState(() {
                              operacion += botones[index];
                            });
                          },
                          botonTxt: botones[index],
                          color: operadores(botones[index])
                              ? Color(0xFFEACFBE)
                              : Colors.white,
                          ColorTxt: operadores(botones[index])
                              ? Color(0XFFFEF3E9)
                              : Color(0XFFEACFBE));
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }


  //Control de operadores.
  bool operadores(String num) {
    if (num == '%' ||
        num == '=' ||
        num == '+' ||
        num == '-' ||
        num == 'x' ||
        num == '/' ||
        num== 'ANS') {
      return true;
    }
    return false;
  }

  //Método para botón =, devolver resultado final.
  void resultadOperacion(){
    String opc = operacion;
    opc = opc.replaceAll('x', '*'); //Reemplazamos x por *, ya que la dependencia math, identifica * para multiplicar.
    opc = opc.replaceAll('%', '/100'); //Reemplazamos % por /100 para llevar a cabo la operación de porcentaje,

    //Dependencia math-expressions
    Parser p = Parser();
    Expression e = p.parse(opc);
    ContextModel c = ContextModel();
    double num = e.evaluate(EvaluationType.REAL, c);

    //Mostramos resultado.
    resultado = num.toString();
    eOpc = operacion;
    operacion = resultado;
    preAns='';
  }

  //Método para botón ANS, preresultado. (Igual al método resultadOperacion())
  void preResultado(){
    String preresultado = operacion;
    preresultado = preresultado.replaceAll('ANS', '='); // Reemplazamos ANS por =, para obtener un resultado provisional.
    preresultado = preresultado.replaceAll('x', '*');
    preresultado = preresultado.replaceAll('%', '/100');

    Parser pr = Parser();
    Expression ex = pr.parse(preresultado);
    ContextModel cx = ContextModel();
    double numR = ex.evaluate(EvaluationType.REAL, cx);

    preAns = numR.toString();
    
  }
}
