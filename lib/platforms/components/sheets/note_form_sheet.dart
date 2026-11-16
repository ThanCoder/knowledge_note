import 'package:knowledge_note/ui/components/index.dart';
import 'package:material_ui/material_ui.dart';

class NoteFormSheet extends StatefulWidget {
  const new({super.key});

  @override
  State<NoteFormSheet> createState() => _NoteFormSheetState();

  static Future<void> show(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => NoteFormSheet(),
    );
  }
}

class _NoteFormSheetState extends State<NoteFormSheet> {
  void _save() async {}
  @override
  Widget build(BuildContext context) {
    return ScrollableColumn(
      children: [
        Row(
          mainAxisAlignment: .end,
          children: [
            FilledButton.tonalIcon(onPressed: _save, label: Text('Save')),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
