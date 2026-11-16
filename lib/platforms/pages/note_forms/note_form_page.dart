import 'package:knowledge_note/core/models/knowledge_note.dart';
import 'package:knowledge_note/ui/index.dart';
import 'package:material_ui/material_ui.dart';

class NoteFormPage extends StatefulWidget {
  const new({super.key, required this.note});
  final KnowledgeNote note;

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  late KnowledgeNote _note = widget.note;

  @override
  void initState() {
    engCon.text = _note.englishName;
    myCon.text = _note.myanmarName;
    descCon.text = _note.description;
    contentCon.text = _note.content;
    super.initState();
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

  Future<void> _save() async {
    if (!formState.currentState!.validate()) return;

    context.pop(
      _note.copyWith(
        englishName: engCon.text,
        myanmarName: myCon.text,
        description: descCon.text,
        content: contentCon.text,
      ),
    );
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
        body: Form(
          key: formState,
          child: ScrollableColumn(
            spacing: 14,
            children: [
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
        ),
      ),
    );
  }
}
