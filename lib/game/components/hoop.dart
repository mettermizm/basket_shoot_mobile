// lib/game/components/hoop.dart
import 'package:basket_shoot_mobile/game/basketball_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../config/constants.dart';

class Hoop extends PositionComponent with HasGameRef<BasketballGame> {
  final Paint _hoopRimPaint = Paint()..color = Colors.red;
  final Paint _hoopBackboardPaint = Paint()..color = Colors.grey.shade800;
  final Paint _hoopNetPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  
  Hoop() : super(
    size: Vector2(
      GameConstants.hoopWidth,
      GameConstants.hoopHeight,
    ),
  );
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;

    // gameRef.canvasSize kullanarak ekranın ortasına yerleştir
    final screenSize = gameRef.size;

    position = Vector2(
      screenSize.x / 2,
      GameConstants.hoopHeight * 1.5,
    );
  }
  
  @override
  void render(Canvas canvas) {
    // Draw backboard
    final backboardRect = Rect.fromLTWH(
      -size.x / 2,
      -size.y / 2,
      size.x / 3,
      size.y,
    );
    canvas.drawRect(backboardRect, _hoopBackboardPaint);
    
    // Draw rim
    final rimRect = Rect.fromLTWH(
      -size.x / 2,
      -GameConstants.hoopThickness / 2,
      size.x,
      GameConstants.hoopThickness,
    );
    canvas.drawRect(rimRect, _hoopRimPaint);
    
    // Draw net (simple representation)
    final netStartY = GameConstants.hoopThickness / 2;
    final netEndY = netStartY + size.y / 2;
    final netWidth = size.x * 0.6;
    final netLeft = -netWidth / 2;
    
    // Vertical net lines
    final numNetLines = 8;
    final netSpacing = netWidth / (numNetLines - 1);
    
    for (int i = 0; i < numNetLines; i++) {
      final x = netLeft + i * netSpacing;
      canvas.drawLine(
        Offset(x, netStartY), 
        Offset(x, netEndY),
        _hoopNetPaint,
      );
    }
    
    // Horizontal net lines
    final numHorizontalLines = 4;
    final horizontalSpacing = (netEndY - netStartY) / (numHorizontalLines - 1);
    
    for (int i = 0; i < numHorizontalLines; i++) {
      final y = netStartY + i * horizontalSpacing;
      canvas.drawLine(
        Offset(netLeft, y),
        Offset(netLeft + netWidth, y),
        _hoopNetPaint,
      );
    }
  }
}