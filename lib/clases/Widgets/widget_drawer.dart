import 'package:flutter/material.dart';
import 'package:gymapp/UI/generales/entrenamientos_page.dart';
import 'package:gymapp/UI/user/login_page.dart';
import 'package:gymapp/usuario/mis_entrenamientos_page.dart';
import 'package:gymapp/UI/generales/anadir_empresa.dart';

// navegacion por pagina
// recordatorio siempre hacer push en el navigator nunca pop
class WidgetDrawer extends StatefulWidget {
  @override
  _WidgetDrawerState createState() => _WidgetDrawerState();
}

class _WidgetDrawerState extends State<WidgetDrawer> {
  @override
  void initState() {
    super.initState();
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return Drawer(
      child: Container(
        color: Colors.black12,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Usuario"),
              accountEmail: Text("usuario@sucorreo.com.mx"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/nousuario.jpg'),
                radius: 25,
              ),
            ),
            ListTile(
              title: Text('crear gimnasio',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              leading: Icon(Icons.accessibility_new, color: Colors.black),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => anadir_emppresa()),
                );
              },
            ),
            ListTile(
              title: Text('Entrenamientos',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              leading: Icon(Icons.accessibility_new, color: Colors.black),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EntrenamientosPage()),
                );
              },
            ),
            ListTile(
              title: Text('Mis Entrenamientos',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              leading: Icon(Icons.accessibility_new, color: Colors.black),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MisEntrenamientosPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ),
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
            ),
            Divider(),
            ListTile(
              title: Container(
                  alignment: Alignment.centerRight,
                  child: Text('gym para niggas')),
            ),
          ],
        ),
      ),
    );
  }
}
