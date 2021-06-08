import 'package:flutter/material.dart';
import 'package:gymapp/clases/Widgets/widget_drawer.dart';

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('nigga_gym'),
        centerTitle: true,
      ),
      drawer: WidgetDrawer(),
      body: Center(
        child: Text(
          "bienvenido a nigga gym",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
