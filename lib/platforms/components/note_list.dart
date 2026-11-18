import 'package:knowledge_note/core/controllers/i_controller.dart';
import 'package:knowledge_note/core/controllers/note_controller.dart';
import 'package:knowledge_note/core/models/note.dart';
import 'package:knowledge_note/platforms/components/note_image.dart';
import 'package:knowledge_note/platforms/components/sheets/note_item_menu_sheet.dart';
import 'package:knowledge_note/ui/index.dart';
import 'package:material_ui/material_ui.dart';

class NoteList extends StatefulWidget {
  const new({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final con = ControllerManager.read<NoteController>();

  void goNoteDetail(Note note) async {}

  void showItemMenu(Note note) async {
    NoteItemMenuSheet.show(context, note);
  }

  ColorScheme get col => context.colorScheme;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: con.events.whereType<NoteControllerLoaded>(),
      builder: (context, asyncSnapshot) {
        return SliverPadding(
          padding: .all(10),
          sliver: SliverMainAxisGroup(
            slivers: [
              if (con.list.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Recently Added',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              if (con.list.isNotEmpty) _listWidget(),
            ],
          ),
        );
      },
    );
    // return _listWidget();
  }

  SliverList _listWidget() {
    return SliverList.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: con.list.length,
      itemBuilder: (context, index) {
        final note = con.list[index];
        return GestureDetector(
          onTap: () => goNoteDetail(note),
          onSecondaryTap: () => showItemMenu(note),
          onLongPress: () => showItemMenu(note),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              padding: .symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: col.surfaceContainer,
                borderRadius: .circular(14),
              ),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 6,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: NoteImage(note: note),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              note.englishName,
                              style: TextStyle(fontSize: 16, fontWeight: .w600),
                            ),
                            Text(
                              note.myanmarName,
                              style: TextStyle(fontSize: 16, fontWeight: .w600),
                            ),
                          ],
                        ),
                      ),

                      Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                  if (note.description.isNotEmpty)
                    Text(
                      note.description,
                      style: TextStyle(fontSize: 11, fontWeight: .w200),
                      maxLines: 3,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
