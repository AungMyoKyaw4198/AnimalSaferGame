import 'package:animal_safer_game/components/animal.dart';
import 'package:animal_safer_game/components/rubbish.dart';
import 'package:animal_safer_game/components/world_collidable.dart';
import 'package:animal_safer_game/helpers/actions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_audio/flame_audio.dart';
import '../animal_safer_game.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef<AnimalSaferGame> , HasHitboxes, Collidable{
  final String name;
  final double width;

  Direction direction = Direction.none;
  PlayerAction playerAction = PlayerAction.none;
  final double playerSpeed = 200.0;

  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;
  late final SpriteAnimation _pickUpAnimation;

  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;

  Player({required this.name,required this.width})
      : super(
          size: Vector2.all(50.0),
        ){
      addHitbox(HitboxRectangle());
    }
     
 
  @override
  Future<void> onLoad() async {
    // sprite = await gameRef.loadSprite('adventurer_stand.png');
    // position = gameRef.size / 2;
    _loadAnimations().then((_) => {animation = _standingAnimation});
    return super.onLoad();
  }


  Future<void> _loadAnimations() async {
   final spriteSheet = SpriteSheet(
    //  image: await gameRef.images.load('characters/adventurer_spritesheet.png'),
     image: await gameRef.images.load(name),
     srcSize: Vector2(80.0, 110.0),
   );

   
    _runDownAnimation =
       spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, from: 1,to: 3);
   
    _runLeftAnimation =
       spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, from: 1,to: 3);
   
    _runRightAnimation =
       spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, from: 3,to: 5);
   
    _runUpAnimation =
       spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, from:3, to: 5);

   _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
    
    _pickUpAnimation =
       spriteSheet.createAnimation(loop: false,row: 0, stepTime: _animationSpeed, from:5, to: 7);

    
 }


  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
    pickUp(playerAction);
  }
 
 // Actions
  void pickUp(PlayerAction action){
    if(action == PlayerAction.pickup){
      animation = _pickUpAnimation;
      playerAction = PlayerAction.none;
    }
  }

 // Moving  Player
  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          FlameAudio.play('walk.mp3');
          animation = _runUpAnimation;
          moveUp(delta);
        }
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          FlameAudio.play('walk.mp3');
          animation = _runDownAnimation;
          moveDown(delta);
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          FlameAudio.play('walk.mp3');
          animation = _runLeftAnimation;
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          FlameAudio.play('walk.mp3');
          animation = _runRightAnimation;
          moveRight(delta);
        }
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
    }
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -playerSpeed));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -playerSpeed, 0));
  }
 
  void moveRight(double delta) {
    position.add(Vector2(delta * playerSpeed, 0));
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if(other is Rubbish || other is Animal){
        _hasCollided = true;
        _collisionDirection = direction;

    }else if (other is WorldCollidable) {
      
      if (!_hasCollided) {
        _hasCollided = true;
        _collisionDirection = direction;
      }
    }
  }
  
  @override
  void onCollisionEnd(Collidable other) {
    _hasCollided = false;
  }

  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }
  
  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }
  
  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }
  
  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }


  
}
