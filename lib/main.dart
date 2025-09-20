import 'package:flutter/material.dart';
import 'dart:math';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Buscaminas - Daniel Gutiérrez Rodríguez'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Lista inicial de números del 1 al 36, Probabilidad del 15% por si una casilla es una Bomba.
  List<int> flags = List.generate(36, (i) => (Random().nextInt(100) > 50) ? 1 : 2 );
  List<String> labels = List.generate(36, (i) => " " );
  // Lista de colores "random", se genera usando el index con mod la longitud del arreglo de colores primarios
  List<Color> colores = List.generate(36, (i) => Colors.grey);
  int userCountBombs = 0;
  int userCountNoBombs = 0;
  

  @override
  Widget build(BuildContext context) {
    int countBombsTotal = flags.where((i) => i == 2).length;
    int countNoBombsTotal = 36 - countBombsTotal;
    

    return Scaffold(
      appBar: AppBar(title: Text("Buscaminas\nDaniel Gutiérrez Rodríguez")),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              children: List.generate(6, (row) {
                return Expanded(
                  child: Row(
                    children: List.generate(6, (col) {
                      int index = row * 6 + col;
                      return Expanded(
                        flex: 1,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            // Si da clic en una casilla buena
                            if (flags[index] == 1){
                              setState(() {
                                colores[index] = Colors.green;
                                labels[index] = "🍀";
                                userCountNoBombs += 1;
                              });
                            }
                            // Si da clic en una bomba
                            if (flags[index] == 2){
                              setState(() {
                                // Saqué el color picker de las imagenes y me dió que era este RGB
                                // Ligeramente diferente al Colors.red que viene por default.
                                colores[index] = const Color.fromRGBO(241, 65, 50, 1);
                                labels[index] = "💣";
                                userCountBombs += 1;
                                
                                
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(4), 
                            color: colores[index],
                            child: Center(
                              child: Text(
                                labels[index],
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(7),
              color: Colors.lightBlue,
              child: 
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    // (userCountBombs == countBombsTotal) ? "HAS PERDIDO" : (userCountNoBombs == countNoBombsTotal) ? "HAS GANADO" : "Conteo: $userCountBombs/$countBombsTotal",
                    "Conteo: Por alguna razón no me funcionó esto, asi que el codigo que no funcionó lo puse en comentario para que al menos no diera problemas al ejecutarse, el contador no se me actualizaba.",
                    style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    ),
                  ),
                )
              ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                setState((){
                  // Lista inicial de números del 1 al 36, Probabilidad del 15% por si una casilla es una Bomba.
                  flags = List.generate(36, (i) => (Random().nextInt(100) > 15) ? 1 : 2 );
                  labels = List.generate(36, (i) => " " );
                  // Lista de colores "random", se genera usando el index con mod la longitud del arreglo de colores primarios
                  colores = List.generate(36, (i) => Colors.grey);
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "Reiniciar Buscaminas",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
    
