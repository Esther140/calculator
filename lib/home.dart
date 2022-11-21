import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String equation="0";
  String result ="0";
  String expression="";
  double expressionFontSize=40.0;
  double resultFontSize =50.0;
  Pressed(String buttonText) {
    setState(() {
      if (buttonText =="C"){
        equation="0";
        result="0";
        expressionFontSize=40.0;
        resultFontSize =50.0;

      }
      else if(buttonText =="⌫"){
        equation =equation.substring(0,equation.length-1);
        if(equation==""){
          expressionFontSize=40.0;
          resultFontSize =50.0;
          equation="0";
        }

      }
      else if(buttonText=="="){
        expressionFontSize=40.0;
        resultFontSize =50.0;
        expression=equation;
        expression =expression.replaceAll(' ×', '*');
        expression =expression.replaceAll('÷', '/');
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm =ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result ="Error";
        }
      }
      else{ if(equation=="0") {
        equation = buttonText;
      }else{
        equation= equation +buttonText;
      }
    }});
  }

  
  Widget buildButton(String ButtonText, double height, Color buttoncolor) {
    return Container(
        height: MediaQuery.of(context).size.width * 0.10 * height,
        color: buttoncolor,
        child: ElevatedButton(
            onPressed:()=>Pressed(ButtonText),
            style: ElevatedButton.styleFrom(
                // backgroundColor: color,
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                0.0,
              ),
              side: const BorderSide(
                  color: Colors.black, style: BorderStyle.solid, width: 1.0),
            )),
            child: Text(
              ButtonText,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
            equation,
              style:  TextStyle(
                fontSize: expressionFontSize,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child:  Text(
              result,
              style:  TextStyle(
                fontSize:resultFontSize,
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.blue),
                      buildButton("⌫", 1, Colors.blue),
                      buildButton("	÷", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.blue),
                      buildButton("8", 1, Colors.blue),
                      buildButton("	9", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.blue),
                      buildButton("5", 1, Colors.blue),
                      buildButton("	6", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.blue),
                      buildButton("2", 1, Colors.blue),
                      buildButton("	3", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.blue),
                      buildButton("0", 1, Colors.blue),
                      buildButton("	00", 1, Colors.blue),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.blue),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

