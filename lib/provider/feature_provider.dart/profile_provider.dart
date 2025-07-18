import 'dart:io';
import 'package:mime/mime.dart'; // Add this import for MIME type detection

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabasetodolist/models/user_model.dart';
import 'package:supabasetodolist/utils/toast_utils.dart';

class ProfileProvider with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  bool isLoading = false;
  File? _pickedImage;
  File? get pickedImage => _pickedImage;
  final ImagePicker _picker = ImagePicker();
  List<UserModel> _userList = [];

  List<UserModel> get userList => _userList;
  String userId = Supabase.instance.client.auth.currentUser!.id.toString();

  Future<void> fetchUserData() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _supabase
          .from('users')
          .select()
          .eq('userId', userId);

      _userList = (response as List<dynamic>)
          .map((data) => UserModel.fromMap(data as Map<String, dynamic>))
          .toList();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching user data from Supabase: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfilePicture(
    ImageSource source,
    BuildContext context,
  ) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      _pickedImage = File(pickedFile.path);
      print('Image selected: ${_pickedImage!.path}');
      await uploadToSupabase(
        _pickedImage!,
        context,
      ); // Fixed: pass _pickedImage and await the call
      print('Image uploaded successfully **********************');
      notifyListeners();
    } else {
      print('No image selected');
    }
  }

  Future<void> uploadToSupabase(File image, BuildContext context) async {
    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final fileBytes = await image.readAsBytes();
      final fileName = userId;
      final mimeType = lookupMimeType(image.path);

      // Upload to storage
      final storageResponse = await supabase.storage
          .from('userprofile')
          .uploadBinary(
            'uploads/$fileName',
            fileBytes,
            fileOptions: FileOptions(contentType: mimeType),
          );

      // Get public URL
      final publicUrl = supabase.storage
          .from('userprofile')
          .getPublicUrl('uploads/$fileName');

      // Update user profile
      final updateResponse = await supabase
          .from('users')
          .update({'image': publicUrl})
          .eq('userId', userId)
          .select();

      if (updateResponse.isEmpty) {
        throw Exception('Failed to update user profile');
      }

      ToastUtil.showToast(
        context,
        message: 'Image uploaded successfully',
        type: ToastType.success,
      );
    } catch (e) {
      print('Error uploading image: $e');
      ToastUtil.showToast(
        context,
        message: 'Image upload failed: ${e.toString()}',
        type: ToastType.error,
      );
    }
  }
}
