import 'package:equatable/equatable.dart';
import 'package:todo_task/features/tasks/data/models/task_model.dart';

// Base abstract class
abstract class TasksHomeState extends Equatable {
  const TasksHomeState();
  
  @override
  List<Object?> get props => [];
}

// Initial state
class CarouselInitial extends TasksHomeState {
  const CarouselInitial();
  
  @override
  List<Object?> get props => [];
}

// State when page changes
class CarouselPageChanged extends TasksHomeState {
  final int currentIndex;
  
  const CarouselPageChanged({required this.currentIndex});
  
  @override
  List<Object?> get props => [currentIndex];
}

// Loading tasks state
class TasksLoading extends TasksHomeState {}

// Tasks loaded successfully state
class TasksLoaded extends TasksHomeState {
  final List<Task> allTasks;
  final List<Task> ongoingTasks;
  final List<Task> completedTasks;
  
  const TasksLoaded({
    required this.allTasks,
    required this.ongoingTasks,
    required this.completedTasks,
  });
  
  @override
  List<Object?> get props => [allTasks, ongoingTasks, completedTasks];
}

// Error state
class TasksError extends TasksHomeState {
  final String message;
  
  const TasksError({required this.message});
  
  @override
  List<Object?> get props => [message];
}