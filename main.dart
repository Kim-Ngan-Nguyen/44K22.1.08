
import 'package:flash_app/blocs/auth_bloc.dart';
import 'package:flash_app/src/resources/home_page.dart';
import 'package:flash_app/src/resources/register_page.dart';
import 'src/app.dart';
import 'src/resources/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value:Authentication(),
          )
        ],
        child: MaterialApp(
          title: 'Login App',
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          home: LoginPage(),
        )
    );
  }
}
