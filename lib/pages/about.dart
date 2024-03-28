import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text(
              "Образовательное учреждение",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 29.0,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name != '/') {
                      Navigator.pushNamed((context), '/');
                    }
                  },
                  child: const Text('Главная'),
                ),
                TextButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name != '/about') {
                      Navigator.pushNamed((context), '/about');
                    }
                  },
                  child: const Text('О нас'),
                ),
                TextButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name != '/add') {
                      Navigator.pushNamed((context), '/add');
                    }
                  },
                  child: const Text('Добавить студента'),
                ),
              ],
            ))
          ],
        ),
      ),
      body: const Column(
        children: [
          Center(
              child: Padding(
                  padding: EdgeInsets.all(48), child: Text('Пока ничего!')))
        ],
      ),
    );
  }
}
