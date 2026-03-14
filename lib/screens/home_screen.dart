import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tester_app/models/app_data.dart';
import '../widgets/LabelButtonRow.dart';
import 'second_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build (BuildContext context){

    final appData = context.watch<AppData>();
    final appData1 = context.read<AppData>();

    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appData.isLoading
            ? Center(child: CircularProgressIndicator())
            : TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter fruits name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            appData.isLoading
            ? Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () {
                  appData1.addFruit(_controller.text);
                  _controller.clear();
                },
                child: Text('Add fruit in List')
            ),
            SizedBox(height: 20),
            LabelButtonRow(
                label: 'Label 1',
                buttonText: 'Button1',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondScreen()
                      )
                  );
                }
                ),
            SizedBox(height: 20),
            appData.isLoading
            ? Center(child: CircularProgressIndicator())
            : LabelButtonRow(
                label: 'Counter: ${appData.counter}',
                buttonText: '+1',
                onPressed: () {
                  appData1.incrementCounter();
                }
            )
          ],
        ),
      ),
    );
  }
}