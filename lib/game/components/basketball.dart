// lib/game/components/basketball.dart
import 'dart:math';
import 'dart:ui';
import 'package:basket_shoot_mobile/game/basketball_game.dart';
import 'package:flame/components.dart'; 
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import '../../config/constants.dart';
import 'hoop.dart';

class Basketball extends PositionComponent
  with DragCallbacks, HasGameRef<BasketballGame> {
  late Vector2 initialPosition;
  late Vector2 dragStartPosition;
  
  Vector2 velocity = Vector2.zero();
  bool isInMotion = false;
  bool hasScored = false;
  bool isDragging = false;
  
  final Paint _ballPaint = Paint()..color = Colors.orange;
  final Paint _ballStripePaint = Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 2.0;
  final Paint _dragLinePaint = Paint()..color = Colors.white..strokeWidth = 3.0;
  
  Basketball() : super(size: Vector2.all(GameConstants.basketballRadius * 2));
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;

    initialPosition = Vector2(
      gameRef.size.x / 2,
      gameRef.size.y - size.y - 20,
    );

    position = initialPosition.clone();
  }
  
  void reset() {
    position = initialPosition.clone();
    velocity = Vector2.zero();
    isInMotion = false;
    hasScored = false;
    isDragging = false;
  }
  
  bool hasContactWithHoop(Hoop hoop) {
    // Simple collision check between ball and hoop
    final hoopRect = Rect.fromLTWH(
      hoop.position.x - hoop.size.x / 2,
      hoop.position.y - hoop.size.y / 2,
      hoop.size.x,
      hoop.size.y,
    );
    
    final ballRect = Rect.fromLTWH(
      position.x - size.x / 2,
      position.y - size.y / 2,
      size.x,
      size.y,
    );
    
    return ballRect.overlaps(hoopRect);
  }
  
  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (!isInMotion) {
      final ballBounds = Rect.fromLTWH(
        position.x - size.x / 2,
        position.y - size.y / 2,
        size.x,
        size.y,
      );

      if (ballBounds.contains(event.canvasPosition.toOffset())) { 
        dragStartPosition = event.canvasPosition.clone();
        isDragging = true;
      }
    }
  }
  
  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (isDragging) {
      final dragPosition = event.canvasStartPosition; // ← doğru kullanım
      if (dragPosition.y > dragStartPosition.y) {
        position = dragPosition.clone();

        final dragDistance = position.distanceTo(initialPosition);
        if (dragDistance > GameConstants.maxDragDistance) {
          final direction = (position - initialPosition).normalized();
          position = initialPosition + direction * GameConstants.maxDragDistance;
        }
      }
    }
  }
  
  @override
  void onDragEnd(DragEndEvent event) {
    if (isDragging) {
      final dragVector = initialPosition - position;
      velocity = dragVector * GameConstants.dragMultiplier;

      final speed = velocity.length;
      if (speed < GameConstants.minVelocity) {
        velocity = velocity.normalized() * GameConstants.minVelocity;
      } else if (speed > GameConstants.maxVelocity) {
        velocity = velocity.normalized() * GameConstants.maxVelocity;
      }

      isInMotion = true;
      isDragging = false;

      //AudioService.playSound(GameConstants.launchSoundPath);
    }
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (isInMotion) {
      // Apply gravity
      velocity.y += GameConstants.gravity * 60 * dt;
      
      // Update position based on velocity
      position += velocity * dt;
    }
  }
  
  @override
  void render(Canvas canvas) {
    // Draw drag indicator line when dragging
    if (isDragging) {
      canvas.drawLine(
        initialPosition.toOffset(),
        position.toOffset(),
        _dragLinePaint,
      );
    }
    
    // Draw the basketball
    canvas.drawCircle(
      Offset.zero,
      GameConstants.basketballRadius,
      _ballPaint,
    );
    
    // Draw basketball stripes
    final radius = GameConstants.basketballRadius;
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: radius),
      0,
      2 * pi,
      false,
      _ballStripePaint,
    );
    
    // Horizontal stripe
    canvas.drawLine(
      Offset(-radius, 0),
      Offset(radius, 0),
      _ballStripePaint,
    );
    
    // Vertical stripe
    canvas.drawLine(
      Offset(0, -radius),
      Offset(0, radius),
      _ballStripePaint,
    );
  }
}