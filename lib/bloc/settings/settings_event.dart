// lib/bloc/settings/settings_event.dart
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  
  @override
  List<Object?> get props => [];
}

class ToggleSound extends SettingsEvent {}

class SetSound extends SettingsEvent {
  final bool enabled;
  
  const SetSound(this.enabled);
  
  @override
  List<Object?> get props => [enabled];
}