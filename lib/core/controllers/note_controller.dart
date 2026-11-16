import 'package:dual_store/dual_store.dart';
import 'package:knowledge_note/core/controllers/i_controller.dart';
import 'package:knowledge_note/core/controllers/result_t.dart';
import 'package:knowledge_note/core/databases/adapters/knowledge_note_adapter.dart';
import 'package:knowledge_note/core/models/knowledge_note.dart';
import 'package:knowledge_note/core/utils/platform_util.dart';
import 'package:knowledge_note/keys.dart';

class NoteControllerLoaded extends IControllerEvent {}

class NoteController extends IController {
  @override
  Future<void> init() async {
    _store.registerAdapter(KnowledgeNoteAdapter());
  }

  final _store = DualStore();
  DuBox<KnowledgeNote> get _box => _store.getBox<KnowledgeNote>();
  List<KnowledgeNote> list = [];

  Future<Result<bool, String>> fetchList() async {
    try {
      final path = PlatformUtil.instance.getDBFolder(name: appNoteDBName);

      final res = await _store.open(path);
      if (res.isErr) {
        return Err(res.unwrapError());
      }
      list = await _box.getAll();
      onSort();
      addEvent(NoteControllerLoaded());

      return Ok(res.unwrap());
    } catch (e) {
      return Err(e.toString());
    }
  }

  void add(KnowledgeNote note) async {
    final res = await _box.add(
      note,
      contentWriter: TextCompressContentWriter(note.content),
    );
    if (res.isOk) {
      list.add(note.copyWith(content: ''));
      onSort();
      addEvent(NoteControllerLoaded());
    }
  }

  void delete(KnowledgeNote note) async {
    final res = await _box.deleteById(note.generatedId);
    if (res.isOk) {
      final index = list.indexWhere((e) => e.id == note.id);
      list.removeAt(index);
      addEvent(NoteControllerLoaded());
    }
  }

  void onSort() {
    list.sort((a, b) => a.updatedAt.second.compareTo(b.updatedAt.second));
  }
}
