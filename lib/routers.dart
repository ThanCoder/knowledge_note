import 'dart:typed_data';

import 'package:knowledge_note/core/models/note.dart';
import 'package:knowledge_note/platforms/pages/note_forms/note_form_page.dart';
import 'package:knowledge_note/ui/build_context_x.dart';
import 'package:material_ui/material_ui.dart';

Future<NoteFormPageResp?> goNoteFormPage(
  BuildContext context,
  Note note, {
  required NoteFormPageRespImageType respImageType,
  Uint8List? imageBytes,
}) async {
  return context.push<NoteFormPageResp>(
    builder: (context) => NoteFormPage(
      note: note,
      respImageType: respImageType,
      imageBytes: imageBytes,
    ),
  );
}
