import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabasetodolist/utils/toast_utils.dart';
import 'package:supabasetodolist/view/auth_view/login_in_Screen.dart';
import 'package:supabasetodolist/view/user_view/home_screen.dart';

class AuthProvider with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<AuthResponse?> signUp(
    BuildContext context,
    String name,
    String email,
    String password,
    String reEnterPassword,
  ) async {
    if (password != reEnterPassword) {
      ToastUtil.showToast(
        context,
        message: 'Password does not match',
        type: ToastType.warning,
      );
    } else {
      try {
        _setLoading(true);
        final response = await _supabase.auth.signUp(
          email: email,
          password: password,
          data: {'name': name},
        );

        var userId = Supabase.instance.client.auth.currentUser!.id.toString();

        userId = Supabase.instance.client.auth.currentUser!.id;
        await Supabase.instance.client.from('users').insert({
          'created_at': DateTime.now().toIso8601String(),
          'name': name.toString(),
          'email': email.toString(),
          'image': '',
          'userId': userId.toString(),
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        return response;
      } catch (e) {
        debugPrint("Sign up error: $e");
        ToastUtil.showToast(
          context,
          message: e.toString(),
          type: ToastType.error,
        );
        return null;
      } finally {
        _setLoading(false);
      }
    }
  }

  Future<AuthResponse?> signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    _setLoading(true);
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      return response;
    } catch (e) {
      debugPrint("Sign in error: $e");
      ToastUtil.showToast(
        context,
        message: e.toString(),
        type: ToastType.error,
      );
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut(BuildContext context) async {
    _setLoading(true);
    try {
      await _supabase.auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      debugPrint("Sign out error: $e");
      ToastUtil.showToast(
        context,
        message: e.toString(),
        type: ToastType.error,
      );
    } finally {
      _setLoading(false);
    }
  }
}
