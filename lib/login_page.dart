import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:kosmeality/api.dart';
import 'package:kosmeality/app_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

const users = const {
  'user@a.fr': 'password',
  'hunter@gmail.com': 'hunter',
};

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic response = await Api().postRequest('/auth', {'user': data.name, 'pwd': data.password}).catchError((dynamic e) {
      return null;
    });
    prefs.setString('token', response.data);
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: FlutterLogin(
        title: 'Connexion',
        logo: 'assets/log_avril.jpg',
        theme: LoginTheme(
          accentColor: Colors.white,
          pageColorDark: Colors.pink,
          pageColorLight: Colors.pink[100],
          titleStyle: TextStyle(
            fontSize: 24,
          ),
        ),
        onLogin: _authUser,
        onSignup: _authUser,
        emailValidator: (String email) {
          return null;
        },
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => AppContainer(),
          ));
        },
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}
