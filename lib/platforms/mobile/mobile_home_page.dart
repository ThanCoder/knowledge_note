import 'package:dart_core_extensions/dart_core_extensions.dart';
import 'package:knowledge_note/core/controllers/i_controller.dart';
import 'package:knowledge_note/core/controllers/note_controller.dart';
import 'package:knowledge_note/core/models/knowledge_note.dart';
import 'package:knowledge_note/core/utils/platform_util.dart';
import 'package:knowledge_note/platforms/components/note_list.dart';
import 'package:knowledge_note/platforms/pages/note_forms/note_form_page.dart';
import 'package:knowledge_note/ui/index.dart';
import 'package:material_ui/material_ui.dart';

class MobileHomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  final pkg = PlatformUtil.instance;
  final con = ControllerManager.read<NoteController>();

  Future<void> init() async {
    if (!await pkg.storagePermissionGranted()) {
      await pkg.reqStoragePermission();
      return;
    }
    final res = await con.fetchList();
    res.onErr(
      onErr: (err) {
        showErrorDialog(context, err);
      },
    );
  }

  void newNote() async {
    final note = await context.push<KnowledgeNote>(
      builder: (context) => NoteFormPage(note: .createEmpty()),
    );
    if (note == null) return;
    con.add(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge Note'),
        actions: [
          if (TPlatform.isDesktop)
            IconButton(onPressed: init, icon: Icon(Icons.refresh_outlined)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newNote,
        child: Icon(Icons.add_card_outlined),
      ),
      body: CustomScrollView(slivers: [NoteList()]),
    );
  }
}
