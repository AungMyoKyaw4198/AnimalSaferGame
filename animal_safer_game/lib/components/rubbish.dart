import 'package:animal_safer_game/helpers/direction.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import '../animal_safer_game.dart';

class Rubbish extends SpriteComponent with HasGameRef<AnimalSaferGame> , HasHitboxes, Collidable {

  final String name;
  final double width;
  Direction direction = Direction.none;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;
  
  Rubbish({required this.name,required this.width})
      : super(
          size: Vector2.all(width),
        ){
          addHitbox(HitboxRectangle());
        }

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(name);
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (!_hasCollided) {
        _hasCollided = true;
        _collisionDirection = direction;
      }
  }
  
  @override
  void onCollisionEnd(Collidable other) {
    _hasCollided = false;
  }

  @override
  void onRemove() {
    _hasCollided = false;
    removeHitbox(HitboxRectangle());
    super.onRemove();
  }
}