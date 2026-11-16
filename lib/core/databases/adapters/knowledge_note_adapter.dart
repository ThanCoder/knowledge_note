import 'package:dual_store/dual_store.dart';
import 'package:knowledge_note/core/models/knowledge_note.dart';

class KnowledgeNoteAdapter extends IDuBinaryMetaAdapter<KnowledgeNote> {
  @override
  int get adapterId => 1;

  @override
  KnowledgeNote fromMap(Map<String, dynamic> map) {
    return .fromJson(map);
  }

  @override
  Map<String, dynamic> toMap(KnowledgeNote value) {
    return value.toJson();
  }
}
