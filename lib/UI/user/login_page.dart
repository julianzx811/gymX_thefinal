import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:gymapp/UI/User/register_page.dart';
import 'package:gymapp/UI/generales/default_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  final formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    _auth.userChanges().listen((event) => setState(() => user = event));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _email.text = 'yulian@hotmail.com';
    _password.text = '123456';
    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [_loginForm(context)],
            )),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 80,
          )),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: [
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                _emailWidget(),
                SizedBox(
                  height: 20,
                ),
                _passwordWidget(),
                SizedBox(
                  height: 30,
                ),
                SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                      icon: Icons.person_add,
                      backgroundColor: Colors.indigo,
                      text: 'registrarse',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      }),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                      icon: Icons.verified_user,
                      backgroundColor: Colors.orange,
                      text: 'iniciar sesion',
                      onPressed: () {
                        _signInWithEmailAndPassword();
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _login() {
    _auth.userChanges().listen((event) => setState(() => user = event));
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      ))
          .user;
      Navigator.of(context) /*!*/ .push(
        MaterialPageRoute<void>(builder: (_) => DefaultPage()),
      );
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with Email & Password'),
        ),
      );
    }
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  Widget _emailWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          onChanged: (valor) {
            _email.text = valor;
          },
          initialValue: _email.text,
          maxLength: 10,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            icon: Icon(
              Icons.mail,
            ),
          ),
          validator: (valor) {
            if (valor.length < 10) {
              return 'Ingrese un correo correcto.';
            } else {
              return null;
            }
          },
        ));
  }

  Widget _passwordWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
            onChanged: (valor) {
              _password.text = valor;
            },
            validator: (valor) {
              if (valor.length < 6) {
                return 'Ingrese su contraseña.';
              } else {
                return null;
              }
            },
            initialValue: _password.text,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              icon: Icon(
                Icons.lock_outline,
              ),
            )));
  }

  Widget _crearBoton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
          onPressed: _iniciaSesion,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 5),
            child: Text('Ingresar'),
          ),
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 0,
          )),
    );
  }

  void _iniciaSesion() async {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('default', (Route<dynamic> route) => false);
  }
}
