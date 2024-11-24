part of 'custom_drawer_cubit.dart';

class CustomDrawerState extends Equatable {
  const CustomDrawerState({this.colorIndex, required this.isDarkMode});

  final int? colorIndex;
  final bool isDarkMode;

  @override
  List<Object> get props => [isDarkMode, colorIndex ?? 0];

  CustomDrawerState copyWith({
    int? colorIndex,
    bool? isDarkMode,
  }) {
    return CustomDrawerState(
      colorIndex: colorIndex ?? this.colorIndex,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
