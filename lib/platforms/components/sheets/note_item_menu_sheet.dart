import 'package:knowledge_note/core/controllers/i_controller.dart';
import 'package:knowledge_note/core/controllers/note_controller.dart';
import 'package:knowledge_note/core/models/note.dart';
import 'package:knowledge_note/routers.dart';
import 'package:knowledge_note/ui/index.dart';
import 'package:material_ui/material_ui.dart';

class NoteItemMenuSheet extends StatefulWidget {
  const new({super.key, required this.note});
  final Note note;

  @override
  State<NoteItemMenuSheet> createState() => _NoteItemMenuSheetState();

  static Future<void> show(BuildContext context, Note note) async {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => NoteItemMenuSheet(note: note),
    );
  }
}

class _NoteItemMenuSheetState extends State<NoteItemMenuSheet> {
  final con = ControllerManager.read<NoteController>();

  void goEditPage() async {
    final formCon = await widget.note.getContentOrNull<String>();
    final imageBytes = await con.getNoteImage(widget.note);

    if (!mounted) return;
    context.pop();
    final edit = await goNoteFormPage(
      context,
      widget.note..formContent = formCon ?? '',
      imageBytes: imageBytes,
      respImageType: imageBytes == null ? .none : .valueExists,
    );
    if (edit == null) return;

    await con.update(edit.note, widget.note.generatedId);

    if (edit.respImageType == .deleted) {
      con.deleteNoteImage(widget.note);
    }
    if (edit.respImageType == .updated) {
      con.updateNoteImage(widget.note, edit.imageBytes!);
    }
    if (edit.respImageType == .added) {
      con.addNoteImage(widget.note, edit.imageBytes!);
    }
    // if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableColumn(
      children: [
        ListTile(
          tileColor: context.colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(borderRadius: .circular(14)),
          title: Text('Edit Note'),
          onTap: goEditPage,
        ),

        SizedBox(height: 30),
      ],
    );
  }
}
