import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MapLoader {
  static Future<List<Rect>> readRayWorldCollisionMap() async {
    final collidableRects = <Rect>[];

    final dynamic collisionMap = json.decode(
        await rootBundle.loadString('assets/AnimalSaferMap.json'));

    for (final dynamic data in collisionMap['objects']) {
      collidableRects.add(Rect.fromLTWH(
          data['x'].toDouble(),
          data['y'].toDouble(),
          data['width'].toDouble(),
          data['height'].toDouble()));
    }

    

    return collidableRects;
  }
}
