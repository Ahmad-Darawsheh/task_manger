import 'package:equatable/equatable.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
  
  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {
  final DateTime today;
  final List<DateTime> weekDays;
  final int selectedDayIndex;
  
  const CalendarInitial({
    required this.today,
    required this.weekDays,
    required this.selectedDayIndex,
  });
  
  @override
  List<Object?> get props => [today, weekDays, selectedDayIndex];
}

class CalendarDaySelected extends CalendarState {
  final DateTime today;
  final List<DateTime> weekDays;
  final int selectedDayIndex;
  
  const CalendarDaySelected({
    required this.today,
    required this.weekDays,
    required this.selectedDayIndex,
  });

  @override
  List<Object?> get props => [today, weekDays, selectedDayIndex];
}