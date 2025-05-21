// lib/game/utils/collision.dart
import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';

class CollisionUtils {
  /// Check if a circle collides with a rectangle
  static bool circleRectCollision(
    Vector2 circleCenter,
    double circleRadius,
    Rect rect,
  ) {
    // Find the closest point on the rectangle to the circle
    final closestX = max(rect.left, min(circleCenter.x, rect.right));
    final closestY = max(rect.top, min(circleCenter.y, rect.bottom));
    
    // Calculate the distance between the circle's center and the closest point
    final distanceX = circleCenter.x - closestX;
    final distanceY = circleCenter.y - closestY;
    
    // If the distance is less than the circle's radius, there is a collision
    final distanceSquared = distanceX * distanceX + distanceY * distanceY;
    return distanceSquared <= circleRadius * circleRadius;
  }
  
  /// Check if a point is inside a circle
  static bool pointCircleCollision(
    Vector2 point,
    Vector2 circleCenter,
    double circleRadius,
  ) {
    final distanceSquared = point.distanceToSquared(circleCenter);
    return distanceSquared <= circleRadius * circleRadius;
  }
  
  /// Check if a ball passes through a hoop (for scoring)
  static bool isBallThroughHoop(
    Vector2 ballPosition,
    double ballRadius,
    Rect hoopRect,
    bool isGoingDown,
  ) {
    // For a successful score, the ball must:
    // 1. Be within the horizontal bounds of the hoop
    // 2. Be at the correct vertical position
    // 3. Be moving downward
    
    if (!isGoingDown) {
      return false;
    }
    
    final ballLeft = ballPosition.x - ballRadius;
    final ballRight = ballPosition.x + ballRadius;
    
    final hoopLeft = hoopRect.left;
    final hoopRight = hoopRect.right;
    
    // Ball should be horizontally within the hoop bounds
    if (ballRight < hoopLeft || ballLeft > hoopRight) {
      return false;
    }
    
    // Ball should be at the right vertical position
    final ballBottom = ballPosition.y + ballRadius;
    final hoopTop = hoopRect.top;
    
    // Ball bottom should be just below the hoop top
    final verticalTolerance = ballRadius * 0.5;
    return (ballBottom > hoopTop) && (ballBottom < hoopTop + verticalTolerance);
  }
}