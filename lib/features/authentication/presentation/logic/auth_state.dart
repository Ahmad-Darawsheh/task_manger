import 'package:equatable/equatable.dart';

// Base authentication state
abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

// Initial state when app starts
class AuthInitial extends AuthState {}

// Loading state during authentication processes
class AuthLoading extends AuthState {}

// Authenticated state when user is logged in
class Authenticated extends AuthState {
  final String userId;
  final String email;
  final String name;
  
  const Authenticated({
    required this.userId,
    required this.email,
    required this.name,
  });
  
  @override
  List<Object?> get props => [userId, email, name];
}

// Unauthenticated state when user is not logged in
class Unauthenticated extends AuthState {}

// Password visibility states
class PasswordVisibilityChanged extends AuthState {
  final bool isLoginPasswordVisible;
  final bool isRegisterPasswordVisible;
  final bool isRegisterConfirmPasswordVisible;
  
  const PasswordVisibilityChanged({
    this.isLoginPasswordVisible = false,
    this.isRegisterPasswordVisible = false,
    this.isRegisterConfirmPasswordVisible = false,
  });
  
  @override
  List<Object?> get props => [isLoginPasswordVisible, isRegisterPasswordVisible, isRegisterConfirmPasswordVisible];
}

// Error states
class AuthError extends AuthState {
  final String message;
  
  const AuthError(this.message);
  
  @override
  List<Object?> get props => [message];
}

class LoginError extends AuthError {
  const LoginError(String message) : super(message);
}

class RegisterError extends AuthError {
  const RegisterError(String message) : super(message);
}

class LogoutError extends AuthError {
  const LogoutError(String message) : super(message);
}

// Success states
class LoginSuccess extends AuthState {}

class RegisterSuccess extends AuthState {}

class LogoutSuccess extends AuthState {}