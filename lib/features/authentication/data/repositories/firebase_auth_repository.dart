import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/features/authentication/data/repositories/base_repo.dart';

class FirebaseAuthRepository implements BaseRepositoryAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  // SharedPreferences keys
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String userNameKey = 'user_name';
  static const String isLoggedInKey = 'is_logged_in';
  
  @override
  Future<bool> login(String email, String password) async {
    try {
      // Attempt to sign in with Firebase
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      // If successful, save user data to SharedPreferences
      if (userCredential.user != null) {
        await _saveUserData(
          userCredential.user!.uid,
          userCredential.user!.email ?? '',
          userCredential.user!.displayName ?? '',
        );
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }
  
  @override
  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      await _clearUserData();
      return true;
    } catch (e) {
      print('Logout error: $e');
      return false;
    }
  }
  
  @override
  Future<bool> register(String email, String password) async {
    try {
      // Create user with Firebase
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      // If successful, save user data to SharedPreferences
      if (userCredential.user != null) {
        await _saveUserData(
          userCredential.user!.uid,
          userCredential.user!.email ?? '',
          userCredential.user!.displayName ?? '',
        );
        return true;
      }
      return false;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }
  
  // Method to update user name after registration
  Future<bool> updateUserName(String name) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        
        // Update the name in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(userNameKey, name);
        return true;
      }
      return false;
    } catch (e) {
      print('Update user name error: $e');
      return false;
    }
  }
  
  // Get current user data
  Future<Map<String, dynamic>> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getString(userIdKey) ?? '',
      'email': prefs.getString(userEmailKey) ?? '',
      'name': prefs.getString(userNameKey) ?? '',
      'isLoggedIn': prefs.getBool(isLoggedInKey) ?? false,
    };
  }
  
  // Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }
  
  // Private method to save user data to SharedPreferences
  Future<void> _saveUserData(String userId, String email, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
    await prefs.setString(userEmailKey, email);
    await prefs.setString(userNameKey, name);
    await prefs.setBool(isLoggedInKey, true);
  }
  
  // Private method to clear user data from SharedPreferences
  Future<void> _clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
    await prefs.remove(userEmailKey);
    await prefs.remove(userNameKey);
    await prefs.setBool(isLoggedInKey, false);
  }
}