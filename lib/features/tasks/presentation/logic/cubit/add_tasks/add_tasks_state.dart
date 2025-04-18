import 'package:equatable/equatable.dart';

abstract class AddTasksState extends Equatable {
  const AddTasksState();
  
  @override
  List<Object?> get props => [];
}

class AddTasksInitial extends AddTasksState {
  const AddTasksInitial();
  
  @override
  List<Object?> get props => [];
}

class CategorySelected extends AddTasksState {
  final String category;
  
  const CategorySelected({required this.category});
  
  @override
  List<Object?> get props => [category];
}

class AddTasksError extends AddTasksState {
  final String message;
  
  const AddTasksError(this.message);
  
  @override
  List<Object?> get props => [message];
}

class TaskCreated extends AddTasksState {
  const TaskCreated();
  
  @override
  List<Object?> get props => [];
}