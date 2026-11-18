import 'dart:typed_data';

import 'package:knowledge_note/platforms/pages/note_forms/note_image_chooser.dart';
import 'package:material_ui/material_ui.dart';

import 'package:knowledge_note/core/models/note.dart';
import 'package:knowledge_note/ui/index.dart';

enum NoteFormPageRespImageType { none, valueExists, updated, deleted, added }

class NoteFormPageResp {
  final Note note;
  final NoteFormPageRespImageType respImageType;
  final Uint8List? imageBytes;

  const NoteFormPageResp({
    required this.note,
    required this.respImageType,
    this.imageBytes,
  });
}

class NoteFormPage extends StatefulWidget {
  const new({
    super.key,
    required this.note,
    required this.respImageType,
    this.imageBytes,
  });
  final Note note;
  final NoteFormPageRespImageType respImageType;
  final Uint8List? imageBytes;

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  late Note _note = widget.note;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formState = GlobalKey<FormState>();
  final engCon = TextEditingController();
  final myCon = TextEditingController();
  final descCon = TextEditingController();
  final contentCon = TextEditingController();
  NoteFormPageRespImageType respImageType = .none;
  Uint8List? imageBytes;

  void init() async {
    engCon.text = _note.englishName;
    myCon.text = _note.myanmarName;
    descCon.text = _note.description;
    contentCon.text = _note.formContent;
    respImageType = widget.respImageType;
    imageBytes = widget.imageBytes;

    setState(() {});
  }

  Future<void> _save() async {
    if (!formState.currentState!.validate()) return;

    final resp = NoteFormPageResp(
      note: _note.copyWith(
        englishName: engCon.text,
        myanmarName: myCon.text,
        description: descCon.text,
      )..formContent = contentCon.text,
      respImageType: respImageType,
      imageBytes: imageBytes,
    );
    context.pop(resp);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final wantToSave = await showConfirmDialog(
          context,
          'Want to Save?',
          closeText: 'No',
          confirmText: 'Save',
        );
        if (!context.mounted) return;
        if (wantToSave) {
          _save();
        } else {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Note Form'),
          actions: [FilledButton(onPressed: _save, child: Text("Save"))],
        ),
        body: _form(),
      ),
    );
  }

  Form _form() {
    return Form(
      key: formState,
      child: ScrollableColumn(
        spacing: 14,
        children: [
          NoteImageChooser(
            bytes: imageBytes,
            onDeleted: () {
              if (widget.respImageType == .valueExists) {
                respImageType = .deleted;
                imageBytes = null;
              }
            },
            onUpdated: (bytes) {
              respImageType = .updated;
              imageBytes = bytes;
            },
            onAdded: (Uint8List bytes) {
              respImageType = .added;
              imageBytes = bytes;
            },
          ),
          SizedBox(height: 10),
          FormInputText(
            controller: engCon,
            inputTextProps: .new(maxLines: 1, label: Text('English Name')),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Required!...';
              }
              return null;
            },
          ),
          FormInputText(
            controller: myCon,
            inputTextProps: .new(maxLines: 1, label: Text('Myanmar Name')),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Required!...';
              }
              return null;
            },
          ),
          FormInputText(
            controller: descCon,
            inputTextProps: .new(maxLines: 1, label: Text('Description')),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Required!...';
              }
              return null;
            },
          ),
          SwitchListTile.adaptive(
            shape: RoundedRectangleBorder(borderRadius: .circular(14)),
            tileColor: context.colorScheme.surfaceContainer,
            title: Text('Favorite'),
            value: _note.isFavorite,
            onChanged: (value) {
              _note = _note.copyWith(isFavorite: value);
              setState(() {});
            },
          ),
          FormInputText(
            controller: contentCon,
            inputTextProps: .new(
              maxLines: null,
              label: Text('Content Markdown'),
            ),
          ),
        ],
      ),
    );
  }
}
