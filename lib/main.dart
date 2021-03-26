import 'package:flutter/material.dart';
import 'input.dart';
import 'result.dart';
import 'convert.dart';
import 'riwayat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //widget dinamis dapat dirubah kapanpun
// This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController inputController = new TextEditingController();

  double _inputUser = 0;
  double _usd = 0;
  double _pounds = 0;

  var listItem = ["USD", "Rupiah", "Poundsterling", "Ringgit"];
  String _newValueResult = "USD";
  String _newValueInput = "Rupiah";
  double _result = 0;

  List<String> listViewItem = List<String>();
  
  final konvertHandler = Function;

  void konversiKurs() {
    setState(() {
      _inputUser = double.parse(inputController.text);
      //Konvertasi dari Rupiah
      if (_newValueInput == "Rupiah") {
        if (_newValueResult == "USD") {
          _result = _inputUser / 14362.20;
        } else if (_newValueResult == "Poundsterling") {
          _result = _inputUser / 20069.30;
        } else if (_newValueResult == "Ringgit") {
          _result = _inputUser / 0.00029;
        } else {
          _result = _inputUser;
        }
        //Konvertasi dari USD
      } else if (_newValueInput == "USD") {
        if (_newValueResult == "USD") {
          _result = _inputUser;
        } else if (_newValueResult == "Poundsterling") {
          _result = _inputUser / 1.40;
        } else if (_newValueResult == "Ringgit") {
          _result = _inputUser * 4.12;
        } else {
          _result = _inputUser * 14362.20;
        }
        //Konvertasi dari Poundsterling
      } else if (_newValueInput == "Poundsterling") {
        if (_newValueResult == "USD") {
          _result = _inputUser * 1.40;
        } else if (_newValueResult == "Poundsterling") {
          _result = _inputUser;
        } else if (_newValueResult == "Ringgit") {
          _result = _inputUser * 5.73;
        } else {
          _result = _inputUser * 20069.30;
        }
      } else {
        if (_newValueResult == "USD") {
          _result = _inputUser / 4.12;
        } else if (_newValueResult == "Poundsterling") {
          _result = _inputUser / 5.73;
        } else if (_newValueResult == "Ringgit") {
          _result = _inputUser;
        } else {
          _result = _inputUser * 3504;
        }
      }
      listViewItem.add("$_newValueInput : $_inputUser -> $_newValueResult : $_result");
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Konverter Mata Uang"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Input(inputController: inputController),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildDropdownButtonInput(),
                  FloatingActionButton(
                    onPressed: () {
                      String temp = _newValueInput;
                      setState(() {
                        _newValueInput = _newValueResult;
                        _newValueResult = temp;
                      });
                    },
                    child: Icon(Icons.swap_horiz),
                    elevation: 0.0,
                    backgroundColor: Colors.yellow[400],
                  ),
                  buildDropdownButtonResult(),
                ],
              ),
              Result(result: _result),
              Convert(konvertHandler: konversiKurs),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Riwayat Konversi",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: RiwayatKonversi(listViewItem: listViewItem),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButtonResult() {
    return DropdownButton<String>(
      items: listItem.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: _newValueResult,
      onChanged: (String changeValue) {
        setState(() {
          _newValueResult = changeValue;
          konversiKurs();
        });
      },
    );
  }

  DropdownButton<String> buildDropdownButtonInput() {
    return DropdownButton<String>(
      items: listItem.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: _newValueInput,
      onChanged: (String changeValue) {
        setState(() {
          _newValueInput = changeValue;
          konversiKurs();
        });
      },
    );
  }
}
