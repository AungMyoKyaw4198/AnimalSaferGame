import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'menu_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animal Safer',
      theme: ThemeData(
        textTheme: TextTheme(
          headline4: TextStyle(fontFamily: 'KenVector',color: Colors.white, overflow: TextOverflow.ellipsis),
          headline3: TextStyle(fontFamily: 'KenVector',color: Colors.blue, overflow: TextOverflow.ellipsis,),
          bodyText2: TextStyle(fontFamily: 'KenVector'),
          button: TextStyle(fontFamily: 'KenVector'),
        )
      ),
      
      home: MainMenu()

    );
  }
}
