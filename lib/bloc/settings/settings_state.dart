// lib/bloc/settings/settings_state.dart
import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool isSoundEnabled;
  
  const SettingsState({
    required this.isSoundEnabled,
  });
  
  factory SettingsState.initial() => const SettingsState(
    isSoundEnabled: true,
  );
  
  SettingsState copyWith({
    bool? isSoundEnabled,
  }) {
    return SettingsState(
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
    );
  }
  
  @override
  List<Object?> get props => [isSoundEnabled];
}
