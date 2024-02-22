part of 'main_cubit.dart';

class MainState extends Equatable {
  const MainState({
    this.colorIndex,
    this.isDarkMode = true,
    this.color,
  });
  final int? colorIndex;
  final bool isDarkMode;
  final Color? color;

  @override
  List<Object> get props => [
        isDarkMode,
        colorIndex ?? 0,
        color ?? Colors,
      ];

  MainState copyWith({
    int? colorIndex,
    bool? isDarkMode,
    Color? color,
  }) {
    return MainState(
      colorIndex: colorIndex ?? this.colorIndex,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      color: color ?? this.color,
    );
  }
}

final class MainInitial extends MainState {}
