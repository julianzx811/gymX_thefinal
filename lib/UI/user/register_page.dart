import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/UI/generales/detalles_entrenamiento_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Entrypoint example for registering via Email/Password.
class RegisterPage extends StatefulWidget {
  /// The page title.
  final String title = 'registro';

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String texto;
  String _userEmail = '';
  String selecion;

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = ["empresario", "administrador", "usuario"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  anadir_empresario(String nombre) {
    CollectionReference empresas =
        FirebaseFirestore.instance.collection('empresarios');
    empresas.add({
      'nombre': nombre,
    });
  }

  anadir_administrador(String nombre) {
    CollectionReference administrador =
        FirebaseFirestore.instance.collection('administradores');
    administrador.add({
      'nombre': nombre,
    });
  }

  anadir_usuario(String nombre) {
    CollectionReference usuario =
        FirebaseFirestore.instance.collection('usuarios');
    usuario.add({
      'nombre': nombre,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration:
                        const InputDecoration(labelText: 'nombre de usuario'),
                    onChanged: (text) {
                      texto = text;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'correo'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'por favor escriba algo';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'contraseña'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'por favor escriba algo';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  DropdownButton(
                    value: selecion,
                    items: _dropDownItem(),
                    onChanged: (value) {
                      selecion = value;
                      switch (value) {
                        case "empresario":
                          anadir_empresario(texto);
                          break;
                        case "administrador":
                          anadir_administrador(texto);
                          break;
                        case "usuario":
                          anadir_usuario(texto);
                          break;
                      }
                    },
                    hint: Text("paginas"),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: SignInButtonBuilder(
                      icon: Icons.person_add,
                      backgroundColor: Colors.blueGrey,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await _register();
                        }
                      },
                      text: 'registrar',
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(_success == null
                        ? ''
                        : (_success
                            ? 'se ha registrado a $_userEmail'
                            : 'fallo en el registro')),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code for registration.
  Future<void> _register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  }
}
