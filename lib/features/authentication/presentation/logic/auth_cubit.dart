import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/features/authentication/data/repositories/firebase_auth_repository.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthRepository authRepository;
  
  // Text controllers for login screen
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  
  // Text controllers for register screen
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController registerConfirmPasswordController = TextEditingController();
  
  // Form keys - use lazy initialization to avoid conflicts
  GlobalKey<FormState>? _loginFormKey;
  GlobalKey<FormState>? _registerFormKey;
  
  // Remember me functionality
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  
  // Getters for form keys that create them only when needed
  GlobalKey<FormState> get loginFormKey => _loginFormKey ??= GlobalKey<FormState>(debugLabel: 'loginFormKey');
  GlobalKey<FormState> get registerFormKey => _registerFormKey ??= GlobalKey<FormState>(debugLabel: 'registerFormKey');
  
  // Password visibility states
  bool _isLoginPasswordVisible = false;
  bool _isRegisterPasswordVisible = false;
  bool _isRegisterConfirmPasswordVisible = false;
  
  // Getters for password visibility
  bool get isLoginPasswordVisible => _isLoginPasswordVisible;
  bool get isRegisterPasswordVisible => _isRegisterPasswordVisible;
  bool get isRegisterConfirmPasswordVisible => _isRegisterConfirmPasswordVisible;
  
  AuthCubit({required this.authRepository}) : super(AuthInitial()) {
    // Check if user is already logged in when cubit is created
    _loadRememberMePreference();
    checkAuthStatus();
  }
  
  void setRememberMe(bool value) {
    _rememberMe = value;
    _saveRememberMePreference();
    // Don't emit a state change that affects the entire UI
    // This prevents the form rebuild issue when toggling remember me
    // after navigating between screens
  }
  
  Future<void> _loadRememberMePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _rememberMe = prefs.getBool('rememberMe') ?? false;
  }
  
  Future<void> _saveRememberMePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', _rememberMe);
  }
  
  // Toggle password visibility for login screen
  void toggleLoginPasswordVisibility() {
    _isLoginPasswordVisible = !_isLoginPasswordVisible;
    emit(PasswordVisibilityChanged(
      isLoginPasswordVisible: _isLoginPasswordVisible,
      isRegisterPasswordVisible: _isRegisterPasswordVisible,
      isRegisterConfirmPasswordVisible: _isRegisterConfirmPasswordVisible,
    ));
  }
  
  // Toggle password visibility for register screen
  void toggleRegisterPasswordVisibility() {
    _isRegisterPasswordVisible = !_isRegisterPasswordVisible;
    emit(PasswordVisibilityChanged(
      isLoginPasswordVisible: _isLoginPasswordVisible,
      isRegisterPasswordVisible: _isRegisterPasswordVisible,
      isRegisterConfirmPasswordVisible: _isRegisterConfirmPasswordVisible,
    ));
  }
  
  // Toggle confirm password visibility for register screen
  void toggleRegisterConfirmPasswordVisibility() {
    _isRegisterConfirmPasswordVisible = !_isRegisterConfirmPasswordVisible;
    emit(PasswordVisibilityChanged(
      isLoginPasswordVisible: _isLoginPasswordVisible,
      isRegisterPasswordVisible: _isRegisterPasswordVisible,
      isRegisterConfirmPasswordVisible: _isRegisterConfirmPasswordVisible,
    ));
  }
  
  // Clear form data
  void clearLoginForm() {
    loginEmailController.clear();
    loginPasswordController.clear();
    // Reset the form key to force a new one to be created next time
    _loginFormKey = null;
  }
  
  void clearRegisterForm() {
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    // Reset the form key to force a new one to be created next time
    _registerFormKey = null;
  }
  
  // Check current authentication status
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final isLoggedIn = await authRepository.isUserLoggedIn();
      
      if (isLoggedIn) {
        final userData = await authRepository.getCurrentUser();
        emit(Authenticated(
          userId: userData['userId'],
          email: userData['email'],
          name: userData['name'],
        ));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError('Failed to check authentication status: $e'));
    }
  }
  
  // Handle login from form
  Future<void> loginWithForm() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      await login(
        loginEmailController.text.trim(),
        loginPasswordController.text.trim(),
      );
    }
  }
  
  // Login user
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final success = await authRepository.login(email, password);
      
      if (success) {
        final userData = await authRepository.getCurrentUser();
        clearLoginForm();
        emit(Authenticated(
          userId: userData['userId'],
          email: userData['email'],
          name: userData['name'],
        ));
      } else {
        emit(const LoginError('Login failed. Check your credentials.'));
      }
    } catch (e) {
      emit(LoginError('Login error: $e'));
    }
  }
  
  // Handle register from form
  Future<void> registerWithForm() async {
    if (registerFormKey.currentState?.validate() ?? false) {
      await register(
        registerEmailController.text.trim(),
        registerPasswordController.text.trim(),
      );
    }
  }
  
  // Register user
  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final success = await authRepository.register(email, password);
      
      if (success) {
        // Update user's name
        await updateUserName(registerNameController.text.trim());
        
        // Get user data after registration
        final userData = await authRepository.getCurrentUser();
        
        // Clear form
        clearRegisterForm();
        
        // Emit authenticated state instead of just registration success
        // This will allow us to navigate directly to the home screen
        emit(Authenticated(
          userId: userData['userId'],
          email: userData['email'],
          name: userData['name'],
        ));
      } else {
        emit(const RegisterError('Registration failed. Please try again.'));
      }
    } catch (e) {
      emit(RegisterError('Registration error: $e'));
    }
  }
  
  // Update user name
  Future<void> updateUserName(String name) async {
    try {
      final success = await authRepository.updateUserName(name);
      
      if (!success) {
        emit(AuthError('Failed to update user name'));
      }
    } catch (e) {
      emit(AuthError('Update user name error: $e'));
    }
  }
  
  // Logout user
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      final success = await authRepository.logout();
      
      if (success) {
        emit(LogoutSuccess());
        emit(Unauthenticated());
      } else {
        emit(const LogoutError('Logout failed'));
      }
    } catch (e) {
      emit(LogoutError('Logout error: $e'));
    }
  }
  
  // Get current user data
  Future<Map<String, dynamic>> getCurrentUserData() async {
    return await authRepository.getCurrentUser();
  }
  
  @override
  Future<void> close() {
    // Dispose all controllers
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    
    // Reset form keys
    _loginFormKey = null;
    _registerFormKey = null;
    
    return super.close();
  }
}