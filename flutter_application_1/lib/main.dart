import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:clipboard/clipboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Calculadora - Reto 1'),
    );
  }
}

class calculadora {
  final titulo;
  final color;
  final icono;

  calculadora(this.titulo, this.color, this.icono);
}

final textOrigen = TextEditingController();
final textDestino = TextEditingController();

String ori = "USD";
String des = "COP";
double USD_COP = 5100;
double USD_EUR = 1.2;
double EUR_COP = 4975;
String copy = "";

List<DropdownMenuItem<String>> ListaMoneda = <DropdownMenuItem<String>>[
  DropdownMenuItem(value: "USD", child: Text("USD")),
  DropdownMenuItem(value: "EUR", child: Text("EUR")),
  DropdownMenuItem(value: "COP", child: Text("COP")),
];

List<calculadora> cal = <calculadora>[
  calculadora("9", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("8", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("7", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("6", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("5", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("4", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("3", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("2", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("1", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("0", Colors.lightGreen[200], Icon(Icons.calculate)),
  calculadora("Borrar", Colors.lightGreen[300], Icon(Icons.cleaning_services)),
  calculadora("Copy", Colors.lightGreen[300], Icon(Icons.copy_sharp)),
];

void calculo() {
  if (ori == "USD" && des == "COP") {
    textDestino.text = NumberFormat.currency(locale: 'es', symbol: '')
        .format(double.parse(textOrigen.text) * USD_COP)
        .toString();
  } else if (ori == "COP" && des == "USD") {
    textDestino.text = NumberFormat.currency(locale: 'en', symbol: '')
        .format(double.parse(textOrigen.text) / USD_COP)
        .toString();
  } else if (ori == "EUR" && des == "COP") {
    textDestino.text = NumberFormat.currency(locale: 'es', symbol: '')
        .format(double.parse(textOrigen.text) * EUR_COP)
        .toString();
  } else if (ori == "COP" && des == "EUR") {
    textDestino.text = NumberFormat.currency(locale: 'es', symbol: '')
        .format(double.parse(textOrigen.text) / EUR_COP)
        .toString();
  } else if (ori == "USD" && des == "EUR") {
    textDestino.text = NumberFormat.currency(locale: 'es', symbol: '')
        .format(double.parse(textOrigen.text) * USD_EUR)
        .toString();
  } else if (ori == "EUR" && des == "USD") {
    textDestino.text = NumberFormat.currency(locale: 'es', symbol: '')
        .format(double.parse(textOrigen.text) / USD_EUR)
        .toString();
  } else {
    textDestino.text = textOrigen.text;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                Text("Origen: "),
                DropdownButton(
                    value: ori,
                    items: ListaMoneda,
                    onChanged: (String? x) {
                      setState(() {
                        ori = x.toString();
                        if (ori == des) {
                          textDestino.text = textOrigen.text;
                        }
                        calculo();
                      });
                    }),
                SizedBox(width: 20),
                Text("Destino: "),
                DropdownButton(
                    value: des,
                    items: ListaMoneda,
                    onChanged: (String? x) {
                      setState(() {
                        des = x.toString();
                        if (ori == des) {
                          textDestino.text = textOrigen.text;
                        }
                        calculo();
                      });
                    }),
                //Text("Cambio"),
                SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.compare_arrows),
                  iconSize: 35,
                  color: Colors.green,
                  splashColor: Colors.green[100],
                  splashRadius: 30,
                  onPressed: () {
                    setState(() {
                      var tmp = ori;
                      ori = des;
                      des = tmp;
                      calculo();
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              readOnly: true,
              controller: textOrigen,
              decoration: InputDecoration(
                  //contentPadding: EdgeInsets.symmetric(vertical: 5),
                  border: OutlineInputBorder(),
                  //labelText: "Origen",
                  hintText: "0",
                  icon: Icon(Icons.monetization_on)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              readOnly: true,
              controller: textDestino,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "0",
                  icon: Icon(Icons.monetization_on)),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: cal.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: cal[index].color,
                    child: ListTile(
                      title: Center(
                        child: index == 10 || index == 11
                            ? cal[index].icono
                            : Text(
                                cal[index].titulo,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                      ),
                      onTap: () {
                        if (index < 10) {
                          textOrigen.text = textOrigen.text + cal[index].titulo;
                          calculo();
                        } else if (index == 10) {
                          textOrigen.clear();
                          textDestino.clear();
                        } else {
                          Clipboard.setData(
                              ClipboardData(text: textDestino.text));
                        }

                        //print(cal[index].titulo);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
