import 'dart:io';
import 'dart:typed_data';

import 'package:dart_core_extensions/dart_core_extensions.dart';
import 'package:knowledge_note/core/controllers/i_controller.dart';
import 'package:knowledge_note/core/controllers/note_controller.dart';
import 'package:knowledge_note/core/models/note.dart';
import 'package:knowledge_note/core/utils/platform_util.dart';
import 'package:material_ui/material_ui.dart';

class NoteImage extends StatefulWidget {
  const new({super.key, required this.note});
  final Note note;

  @override
  State<NoteImage> createState() => _NoteImageState();
}

class _NoteImageState extends State<NoteImage> {
  final con = ControllerManager.read<NoteController>();

  File get imgF =>
      PlatformUtil.instance.getCacheFolder('${widget.note.id}.png').file;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: .circular(20), child: body());
  }

  Widget body() {
    return FutureBuilder(
      future: con.getNoteImage(widget.note),
      builder: (context, snapshot) {
        if (snapshot.connectionState == .waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        final bytes = snapshot.data;
        if (bytes != null) {
          return _imgMem(bytes);
        }

        return _defImage();
      },
    );
  }

  Image _defImage() => Image.asset('assets/logo/app_logo.png');

  Widget _imgMem(Uint8List bytes) {
    return Image.memory(
      bytes,
      errorBuilder: (context, error, stackTrace) => _defImage(),
    );
  }

  // Widget _imgWidget() {
  //   if (imgF.existsSync()) {
  //     return Image.file(
  //       imgF,
  //       errorBuilder: (context, error, stackTrace) => _defImage(),
  //     );
  //   }
  //   return _defImage();
  // }
}
