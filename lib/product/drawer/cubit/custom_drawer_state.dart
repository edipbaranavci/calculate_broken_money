part of 'custom_drawer_cubit.dart';

class CustomDrawerState extends Equatable {
  const CustomDrawerState({this.colorIndex, this.isDarkMode});

  final int? colorIndex;
  final bool? isDarkMode;

  @override
  List<Object> get props => [
        isDarkMode ?? true,
        colorIndex ?? 0,
      ];

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

final class CustomDrawerInitial extends CustomDrawerState {}
