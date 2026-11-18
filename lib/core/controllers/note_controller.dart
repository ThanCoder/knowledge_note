import 'dart:io';
import 'dart:typed_data';

import 'package:dual_store/dual_store.dart';
import 'package:knowledge_note/core/controllers/i_controller.dart';
import 'package:knowledge_note/core/controllers/result_t.dart';
import 'package:knowledge_note/core/databases/adapters/note_adapter.dart';
import 'package:knowledge_note/core/databases/adapters/note_img_adapter.dart';
import 'package:knowledge_note/core/models/note.dart';
import 'package:knowledge_note/core/models/note_img.dart';
import 'package:knowledge_note/core/utils/platform_util.dart';
import 'package:knowledge_note/keys.dart';

class NoteControllerLoaded extends IControllerEvent {}

class NoteController extends IController {
  @override
  Future<void> init() async {
    _store.registerAdapter(NoteAdapter());
    _store.registerAdapter(NoteImgAdapter());

    _store.imageBox.events.all.listen((e) {
      print('img: $e');
    });
  }

  final _store = DualStore();
  DuBox<Note> get _box => _store.getBox<Note>();
  DuBox<NoteImg> get noteImgBox => _store.getBox<NoteImg>();
  List<Note> list = [];

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

  Future<Note?> add(Note note) async {
    final res = await _box.add(
      note,
      contentWriter: TextCompressContentWriter(note.formContent),
    );
    if (res.isOk) {
      list.add(res.unwrap());

      onSort();
      addEvent(NoteControllerLoaded());
      return res.unwrap();
    }
    return null;
  }

  Future<void> update(Note note, int generatedId) async {
    final res = await _box.updateById(
      generatedId,
      value: note,
      contentWriter: TextCompressContentWriter(note.formContent),
    );
    if (res.isOk) {
      final index = list.indexWhere((e) => e.id == note.id);
      if (index == -1) return;
      list[index] = res.unwrap();
      onSort();
      addEvent(NoteControllerLoaded());
    }
  }

  Future<void> delete(Note note) async {
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

  // image
  Future<void> addNoteImage(Note note, Uint8List bytes) async {
    await _store.imageBox.add(
      .fromBytes(
        bytes,
        name: note.id,
        ext: 'png',
        lastModified: .now(),
        parentId: note.generatedId,
        extra: {'noteId': note.id},
      ),
    );
    addEvent(NoteControllerLoaded());
  }

  Future<void> deleteNoteImage(Note note) async {
    final res = await _store.imageBox.findOne(
      (e) => e.extra['noteId'] == note.id,
    );
    if (res == null) return;
    await res.delete();
    addEvent(NoteControllerLoaded());
  }

  Future<void> updateNoteImage(Note note, Uint8List bytes) async {
    final res = await _store.imageBox.findOne(
      (e) => e.extra['noteId'] == note.id,
    );
    if (res == null) return;
    await _store.imageBox.updateById(
      res.parentId,
      file: .fromBytes(
        bytes,
        name: res.name,
        ext: res.ext,
        lastModified: .now(),
        parentId: note.generatedId,
        extra: {'noteId': note.id},
      ),
    );
    addEvent(NoteControllerLoaded());
  }

  Future<Uint8List?> getNoteImage(Note note) async {
    final res = await _store.imageBox.findOne(
      (e) => e.extra['noteId'] == note.id,
    );
    if (res == null) return null;

    return await res.imageData;
  }

  Future<void> genNoteImage(Note note, File outfile) async {
    if (outfile.existsSync()) {
      return;
    }
    final bytes = await getNoteImage(note);
    if (bytes == null) return;
    await outfile.writeAsBytes(bytes);

    // await Future.delayed(Duration(seconds: 2));
  }
}
