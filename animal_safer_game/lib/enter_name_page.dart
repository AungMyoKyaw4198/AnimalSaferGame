import 'package:animal_safer_game/level_page.dart';
import 'package:animal_safer_game/sharePref/share_pref.dart';
import 'package:animal_safer_game/utils/game_constant.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class EnterNamePage extends StatefulWidget {
  EnterNamePage({Key? key}) : super(key: key);

  @override
  _EnterNamePageState createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  TextEditingController _textController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),BlendMode.srcOver), 
            image: AssetImage(
              'assets/images/map/TestMap.png'
            )
          )
        ),

        child: Container(
                  height: MediaQuery.of(context).size.height -300,
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text('Enter name',
                    style: Theme.of(context).textTheme.headline4,
                  ),

                  

                  TextField(
                    style: Theme.of(context).textTheme.button,
                    controller: _textController,                                                          
                    decoration: InputDecoration( 
                      filled: true,
                      fillColor: Colors.white54,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black45, width: 3.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusColor: Colors.white,
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      hintText: 'Enter Name',
                      border :OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 10.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ), 
                    
                    ),  
                  ),

                  Container(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Image.asset('assets/images/ui/yellow_sliderRight.png',height: 50,width: 50,),
                      onPressed: (){
                        if(_textController.text.isEmpty) {
                          FlameAudio.play('error.ogg');
                          setState(() {
                            _validate = true;
                          });
                        }
                        else{
                          FlameAudio.play('click.ogg');
                          setState(() {
                            _validate = false;
                          });
                          currentPlayer.name = _textController.text;
                          currentPlayer.level = 1;

                          SharePref.saveData('player',currentPlayer);
                          
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context){
                              return LevelPage();
                            })
                          );
                        }
                        
                      },
                    ),
                  )

                ],
              ),
        ),
      ),

      
    );
  }
}