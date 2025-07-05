import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/models/note_model.dart';
import 'package:todo_list/utils/toast_utils.dart';

class NoteProvider with ChangeNotifier {
  final _supabase = Supabase.instance.client.from('mynotes');
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<NoteModel> noteList = [];

  void onInit(BuildContext context) {
    getNotes(context);
  }

  /// get notes
  Future<void> getNotes(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      print('trying to fetch data');
      final stream = _supabase.stream(primaryKey: ['id']);
      stream.listen((data) {
        noteList.clear();
        noteList.addAll(
          data.map((noteMap) => NoteModel.fromMap(noteMap)).toList(),
        );
        print('Data is successfully fetched');
        notifyListeners();
      });
    } catch (e) {
      ToastUtil.showToast(
        context,
        message: e.toString(),
        type: ToastType.error,
      );
    } finally {
      _isLoading = false;
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
      _isLoading = true;
      notifyListeners();

      print('trying to add data********************');
      await _supabase.insert({
        'title': title.toString(),
        'description': description.toString(),
      });
      print('data is added********************');
      Navigator.pop(context);

      // Optionally, refresh the list
      await getNotes(context);
    } catch (e) {
      print(e.toString());
      ToastUtil.showToast(
        context,
        message: e.toString(),
        type: ToastType.error,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // delete notes
  Future<void> deleteNote(BuildContext context, String docId) async {
    try {
      _isLoading = true;
      notifyListeners();
      print('trying to delete note');

      await _supabase.delete().eq('id', docId);
      print('Successfully note is deleted');

      await getNotes(context);
    } catch (_e) {
      ToastUtil.showToast(
        context,
        message: _e.toString(),
        type: ToastType.error,
      );
    } finally {
      _isLoading = false;
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
      _isLoading = true;
      notifyListeners();
      print('trying to update note');
      await _supabase
          .update({
            'title': title.toString(),
            'description': description.toString(),
          })
          .eq('id', noteId);
      print('note updated Successfully');
      await getNotes(context);
    } catch (_e) {
      ToastUtil.showToast(
        context,
        message: _e.toString(),
        type: ToastType.error,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
