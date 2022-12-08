import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

import './modelSigns.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<modelSigns> buttonsSign = [
    modelSigns(7, false, Colors.green),
    modelSigns(8, false, Colors.green),
    modelSigns(9, false, Colors.green),
    modelSigns('/', true, Colors.orange),
    modelSigns(4, false, Colors.green),
    modelSigns(5, false, Colors.green),
    modelSigns(6, false, Colors.green),
    modelSigns('*', true, Colors.orange),
    modelSigns(1, false, Colors.green),
    modelSigns(2, false, Colors.green),
    modelSigns(3, false, Colors.green),
    modelSigns('-', true, Colors.orange),
    modelSigns('C', true, Colors.red),
    modelSigns(0, false, Colors.green),
    modelSigns('00', false, Colors.green),
    modelSigns('+', true, Colors.orange),
  ];

  String action = '';
  double result = 0;
  modelSigns? lastSign = null;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.4,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      action,
                      style: TextStyle(color: Colors.green, fontSize: 30),
                    ),
                    SelectableText(
                      result.toString(),
                      style: TextStyle(
                          color: action.isEmpty ? Colors.black : Colors.orange,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: GridView.builder(
                            itemCount: buttonsSign.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 17, 17, 17),
                                          foregroundColor: Colors.green,
                                          shape: CircleBorder()),
                                      onPressed: () {
                                        if (action.isEmpty &&
                                            buttonsSign[index].isSpecial) {
                                          return;
                                        }
                                        if (buttonsSign[index].value == 'C') {
                                          setState(() {
                                            action = '';
                                            result = 0;
                                          });
                                          return;
                                        }
                                        if (!action.isEmpty) {
                                          if (lastSign != null) {
                                            if (buttonsSign[index].isSpecial ==
                                                    true &&
                                                lastSign!.isSpecial == true) {
                                              return;
                                            }
                                          }
                                        }
                                        lastSign = buttonsSign[index];

                                        setState(() {
                                          action = action +
                                              buttonsSign[index]
                                                  .value
                                                  .toString();
                                        });
                                        lastSign = buttonsSign[index];
                                        if (!lastSign!.isSpecial) {
                                          setState(() {
                                            result =
                                                action.interpret().toDouble();
                                          });
                                        }
                                      },
                                      child: Text(
                                        buttonsSign[index].value.toString(),
                                        style: TextStyle(
                                            color: buttonsSign[index].color),
                                      )),
                                )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
