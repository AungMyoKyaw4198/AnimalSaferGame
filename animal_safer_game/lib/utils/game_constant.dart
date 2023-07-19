import 'package:animal_safer_game/ob/level_ob.dart';
import 'package:animal_safer_game/ob/player_data.dart';

// int currentLevel = 1;
// int currentTotalScore = 4;

// String currentCharacter = 'characters/adventurer_spritesheet.png';

String currentMap = 'map/AnimalSaferMap1.png';

PlayerData currentPlayer = PlayerData(
  name: '',
  character: 'characters/adventurer_spritesheet.png',
  characterFace: 'assets/images/characters/faces/adventurer.png',
  level: 0,
  currentScore: 0,
  worldValue: 0.0
);

List<String> characterFacesList = [
  'assets/images/characters/faces/adventurer.png',
  'assets/images/characters/faces/female.png',
  'assets/images/characters/faces/player.png',
  'assets/images/characters/faces/soldier.png',
  'assets/images/characters/faces/zombie.png',

];

List<String> dialogText = [
    'Hello, player',
    'We live in bad distropic world , everything is broken, grass burned or only sand, river dry, mointains are not nice....',
    'I am super happy that you are here. The world turned bad because people did not care..',
    'You maybe the hero we waited for so long.',
    'To help us, you need to collect RUBBISH throughout the Forest.',
    'By collcecting, rubbish, you can earn SEEDs.',
    'You can Renew our world to be cleaner by using the SEED.',
    'You can Renew it in the Shop.',
    'You need to collected all the rubish for now but the wind brings up new rubish from time to time.',
    'I believe You will up for the task.',
    'I hopes that more animals return if they hear it. Finally some hope!...'
  ];

List<RubbishType> allRubbishList = [
  RubbishType(name: 'rubbish/bush1.png', width: 25.0, amount: 30),
  RubbishType(name: 'rubbish/bush3.png', width: 25.0, amount: 30),
  RubbishType(name: 'rubbish/bushOrange1.png', width: 25.0, amount: 30),
  RubbishType(name: 'rubbish/bushOrange3.png', width: 25.0, amount: 20),
];

double audioVolume = 1.0;