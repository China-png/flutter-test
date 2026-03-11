import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tester_app/models/app_data.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatefulWidget{
  const SecondScreen({
    super.key,
  });

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>{
  @override
  Widget build (BuildContext context) {

    final appData = context.watch<AppData>(); // Подключаемся к "радиостанции" 📻
    final appData1 = context.read<AppData>();

    return Scaffold(
      appBar: AppBar(
        title: Text('SecondScreen', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: appData.fruits.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.accessible_forward_sharp, size: 20),
              title: Text('${appData.fruits[index]}'),
              subtitle: Text('index in fruits: $index'),
              trailing: IconButton(
                  onPressed: () {
                    appData1.removeFruit(index);
                  },
                  icon: Icon(Icons.delete_outline_sharp, color: Colors.red)),
            );
          }),
    );
  }
}