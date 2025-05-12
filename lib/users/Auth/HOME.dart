import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // You can add drawer open logic or menu action here
          },
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Labo sheey hadaa is ku aragto oo ah Xaasidnimo iyo Isla waayin . "
            "Naftaada ku noqo Isxiyaabi . Aniga Waxa ii latahy  Waa Habaarantahay",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
