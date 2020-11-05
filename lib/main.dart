import 'package:flutter/material.dart';
import 'package:project_one/ui/info_page.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: App(),
  routes: <String, WidgetBuilder>{
        '/screen1':(BuildContext context) => App(),
        '/screen2': (BuildContext context) => InfoPage()
      },
));
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Scaffold(body: InfoPage()),
      title: Text('bubble',
      style: TextStyle(
        color: Colors.blue,
        fontFamily: 'Pacifico',
        fontSize: 40
      ),
      ),
      image: Image.asset('assets/images/clean (2).png',),
      photoSize: 100,
      backgroundColor: Colors.black,
      
    );
  }
}