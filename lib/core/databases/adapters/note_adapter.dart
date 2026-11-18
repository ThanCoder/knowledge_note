import 'package:dual_store/dual_store.dart';
import 'package:knowledge_note/core/models/note.dart';

class NoteAdapter extends IDuBinaryMetaAdapter<Note> {
  @override
  int get adapterId => 1;

  @override
  Note fromMap(Map<String, dynamic> map) {
    return .fromJson(map);
  }

  @override
  Map<String, dynamic> toMap(Note value) {
    return value.toJson();
  }
}
