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