import 'package:flutter/material.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var _currentPage = LoginPage();

  @override
  Widget build(BuildContext) {
    return Scaffold(
      body: _currentPage,
    );
  }
}
