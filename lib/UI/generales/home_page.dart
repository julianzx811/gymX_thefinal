import 'package:flutter/material.dart';
import 'package:gymapp/clases/Widgets/widget_drawer.dart';

// porfa matenme
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('nigga_gym_App')),
        drawer: WidgetDrawer(),
        body: Container(
          child: Center(
            child: Text('menu'),
          ),
        ));
  }
}
