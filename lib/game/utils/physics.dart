// lib/game/utils/physics.dart
import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';

class PhysicsUtils {
  /// Calculate trajectory position at time t
  static Vector2 calculateTrajectoryPosition(
    Vector2 initialPosition,
    Vector2 initialVelocity,
    double gravity,
    double time,
  ) {
    final x = initialPosition.x + initialVelocity.x * time;
    final y = initialPosition.y + initialVelocity.y * time + 0.5 * gravity * time * time;
    
    return Vector2(x, y);
  }
  
  /// Calculate the launch angle in radians
  static double calculateLaunchAngle(Vector2 initialVelocity) {
    return atan2(-initialVelocity.y, initialVelocity.x);
  }
  
  /// Calculate launch velocity needed to hit a target
  static Vector2 calculateLaunchVelocityToTarget(
    Vector2 start,
    Vector2 target,
    double gravity,
    double angle,
  ) {
    final dx = target.x - start.x;
    final dy = target.y - start.y;
    final cosAngle = cos(angle);
    final tanAngle = tan(angle);
    
    // Calculate required velocity magnitude
    final v = sqrt(
      (gravity * dx * dx) / 
      (2 * cosAngle * cosAngle * (dy - dx * tanAngle))
    );
    
    return Vector2(
      v * cosAngle,
      -v * sin(angle),
    );
  }
  
  /// Check if a trajectory will pass through a certain area
  static bool willTrajectoryPassThroughArea(
    Vector2 initialPosition,
    Vector2 initialVelocity,
    double gravity,
    Rect targetArea,
    {double timeStep = 0.016, double maxTime = 10.0}
  ) {
    double time = 0;
    
    while (time < maxTime) {
      final position = calculateTrajectoryPosition(
        initialPosition,
        initialVelocity,
        gravity,
        time,
      );
      
      if (targetArea.contains(position.toOffset())) {
        return true;
      }
      
      time += timeStep;
    }
    
    return false;
  }
}