import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kosmeality/home_page.dart';
import 'package:kosmeality/navigator_key.dart';
import 'package:kosmeality/profil_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({
    Key key,
  }) : super(key: key);

  @override
  AppContainerState createState() => AppContainerState();
}

class AppContainerState extends State<AppContainer> {
  int _currentIndex = 0;
  bool _loading = false;

  void _onTabTapped(dynamic index) {
    if (_currentIndex != index || privateNavKey.currentState.canPop()) {
      switch (index) {
        case 0:
          privateNavKey.currentState.pushAndRemoveUntil(
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => HomePage(),
            ),
            (Route<dynamic> route) => false,
          );
          break;
        case 1:
          privateNavKey.currentState.pushAndRemoveUntil(
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ProfilPage(),
            ),
            (Route<dynamic> route) => false,
          );
          break;
      }
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Function show = () => <void>{
          setState(() {
            _loading = true;
          })
        };

    final Function hide = () => <void>{
          setState(() {
            _loading = false;
          })
        };

    /// List that contains show and hide functions to manage the
    /// loader ([ModalProgressHUD]) visibility
    final List<Function> functionsDialogs = <Function>[show, hide];

    return ModalProgressHUD(
      opacity: 0.5,
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(),
      child: Provider<List<Function>>.value(
        value: functionsDialogs,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (dynamic i) => _onTabTapped(i),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profil')),
            ],
          ),
          body: Center(
            child: WillPopScope(
              onWillPop: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else if (privateNavKey.currentState.canPop()) {
                  privateNavKey.currentState.pop();
                } else {
                  SystemNavigator.pop();
                }
                return;
              },
              //Navigator for the BottomNavigationBar
              child: Navigator(
                key: privateNavKey,
                onGenerateRoute: (RouteSettings settings) {
                  return MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => HomePage(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
