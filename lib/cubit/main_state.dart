// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_cubit.dart';

class MainState extends Equatable {
  const MainState({
    this.colorIndex,
    this.isDarkMode,
    this.color,
  });
  final int? colorIndex;
  final bool? isDarkMode;
  final Color? color;

  @override
  List<Object> get props => [
        isDarkMode ?? true,
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
