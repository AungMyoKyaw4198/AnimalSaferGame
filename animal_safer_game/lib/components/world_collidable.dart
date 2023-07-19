import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import '../animal_safer_game.dart';
 
 
class WorldCollidable extends PositionComponent with HasGameRef<AnimalSaferGame>, HasHitboxes, Collidable {
  
  WorldCollidable() {
    addHitbox(HitboxRectangle());
  }
}
