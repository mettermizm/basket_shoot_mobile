// lib/bloc/settings/settings_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../services/audio_service.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    on<ToggleSound>(_onToggleSound);
    on<SetSound>(_onSetSound);
    
    // Initialize audio service with current settings
    _initializeSettings();
  }
  
  void _initializeSettings() {
    AudioService.setMuted(!state.isSoundEnabled);
  }
  
  void _onToggleSound(ToggleSound event, Emitter<SettingsState> emit) {
    final newValue = !state.isSoundEnabled;
    emit(state.copyWith(isSoundEnabled: newValue));
    AudioService.setMuted(!newValue);
  }
  
  void _onSetSound(SetSound event, Emitter<SettingsState> emit) {
    emit(state.copyWith(isSoundEnabled: event.enabled));
    AudioService.setMuted(!event.enabled);
  }
  
  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState(
      isSoundEnabled: json['isSoundEnabled'] as bool,
    );
  }
  
  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {
      'isSoundEnabled': state.isSoundEnabled,
    };
  }
}