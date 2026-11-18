import 'package:dual_store/dual_store.dart';
import 'package:knowledge_note/core/models/note_img.dart';

class NoteImgAdapter extends IDuBinaryMetaAdapter<NoteImg> {
  @override
  int get adapterId => 2;

  @override
  NoteImg fromMap(Map<String, dynamic> map) {
    return .fromJson(map);
  }

  @override
  Map<String, dynamic> toMap(NoteImg value) {
    return value.toJson();
  }
}
