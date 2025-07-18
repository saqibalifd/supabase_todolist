import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabasetodolist/models/note_model.dart';
import 'package:supabasetodolist/utils/toast_utils.dart';

class NoteProvider with ChangeNotifier {
  final _supabase = Supabase.instance.client.from('notes');
  bool isLoading = false;

  final List<NoteModel> noteList = [];

  void onInit(BuildContext context) {
    getNotes(context);
  }

  /// get notes
  Future<void> getNotes(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      String userId = Supabase.instance.client.auth.currentUser!.id.toString();
      final stream = _supabase.stream(primaryKey: ['id']).eq('userId', userId);
      stream.listen((data) {
        noteList.clear();
        noteList.addAll(
          data.map((noteMap) => NoteModel.fromMap(noteMap)).toList(),
        );
        notifyListeners();
      });
    } catch (e) {
      ToastUtil.showToast(
        context,
        message: e.toString(),
        type: ToastType.error,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new note
  Future<void> addNote(
    BuildContext context,
    String title,
    String description,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      String userId = Supabase.instance.client.auth.currentUser!.id.toString();

      await _supabase.insert({
        'created_at': DateTime.now().toIso8601String(),
        'title': title.toString(),
        'description': description.toString(),
        'userId': userId.toString(),
      });

      Navigator.pop(context);
      ToastUtil.showToast(
        context,
        message: 'Note added Successfull',
        type: ToastType.success,
      );
      // Optionally, refresh the list
      await getNotes(context);
    } catch (e) {
      ToastUtil.showToast(
        context,
        message: e.toString(),
        type: ToastType.error,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // delete notes
  Future<void> deleteNote(BuildContext context, String docId) async {
    try {
      isLoading = true;
      notifyListeners();
      print('trying to delete note');

      await _supabase.delete().eq('id', docId);

      getNotes(context);
      ToastUtil.showToast(
        context,
        message: 'Note Deleted Successfull',
        type: ToastType.warning,
      );
    } catch (_e) {
      ToastUtil.showToast(
        context,
        message: _e.toString(),
        type: ToastType.error,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // update notess
  Future<void> updateNote(
    BuildContext context,
    String docId,
    String title,
    String description,
    String noteId,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      await _supabase
          .update({
            'title': title.toString(),
            'description': description.toString(),
          })
          .eq('id', noteId);

      Navigator.pop(context);
      getNotes(context);
      ToastUtil.showToast(
        context,
        message: 'Note Updated Successfull',
        type: ToastType.success,
      );
    } catch (_e) {
      ToastUtil.showToast(
        context,
        message: _e.toString(),
        type: ToastType.error,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
