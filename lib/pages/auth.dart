import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/auth/authentication.dart';

/// Displays a list of SampleItems.
class AuthView extends StatefulWidget {
  const AuthView({super.key});

  static const routeName = '/auth';

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  String? errorMessage = '';

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: loginController.text, password: passwordController.text);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Успешный вход!')));
      Navigator.pushNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Произошла ошибка!')));
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: loginController.text, password: passwordController.text);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Успешная регистрация!')));
      Navigator.pushNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Произошла ошибка!')));
      });
    }
  }

  Widget _errorMessage() {
    return Text(
        errorMessage == '' ? '' : 'Что-то пошло не так... $errorMessage');
  }

  Widget _submitButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (isLogin) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Выполняется вход...')));
                signInWithEmailAndPassword();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Выполняется регистрация...')));
                createUserWithEmailAndPassword();
              }
            }
          },
          child: Text(isLogin ? 'Войти в приложение' : 'Зарегистрироваться'),
        ));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Зарегистрироваться' : 'Войти'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
              child: Column(
                children: <Widget>[
                  const Text(
                    "Образовательное учреждение",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 29.0,
                        fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите логин';
                      }
                      return null;
                    },
                    controller: loginController,
                    decoration:
                        const InputDecoration(hintText: 'Введите логин'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите пароль';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: passwordController,
                      decoration:
                          const InputDecoration(hintText: 'Введите пароль'),
                    ),
                  ),
                  _errorMessage(),
                  _submitButton(),
                  _loginOrRegisterButton()
                ],
              ),
            )));
  }
}
