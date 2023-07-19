import 'package:animal_safer_game/menu_page.dart';
import 'package:animal_safer_game/utils/game_constant.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double _currentSliderValue = 0;

  @override
  void initState() {
    _currentSliderValue = audioVolume*100;
    super.initState();
  }

  @override
  void dispose() {
    audioVolume = _currentSliderValue*0.01;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),BlendMode.srcOver), 
            image: AssetImage(
              'assets/images/map/TestMap.png'
            )
          )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 IconButton(
                   icon: Image.asset('assets/images/ui/yellow_sliderLeft.png',height: 50,width: 50,),
                   onPressed: (){
                     FlameAudio.play('click.ogg');
                     Navigator.of(context).pushReplacement(
                       MaterialPageRoute(builder: (BuildContext context){
                         return MainMenu();
                       })
                     );
                   },
                 ),
                 
                Text('Settings', style: Theme.of(context).textTheme.headline4,),
              ],
            ),

            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(15, 15),bottom: Radius.elliptical(15, 15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sound', style: Theme.of(context).textTheme.headline4,),

                    SizedBox(height: 30,),
                    Text('Volume', style: Theme.of(context).textTheme.headline4,),
                    Slider(
                      value: _currentSliderValue,
                      max: 100,
                      divisions: 5,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),

                  ],
                ),
              ),
            ),

            SizedBox(height: 30,),

            Expanded(
              
              flex:1,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(15, 15),bottom: Radius.elliptical(15, 15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact Info', style: Theme.of(context).textTheme.headline4,),
                    SizedBox(height: 20,),
                    Text('Alex Hanter'),
                    Text('www.example.com'),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}