import 'package:knowledge_note/core/controllers/i_controller.dart';
import 'package:knowledge_note/core/controllers/note_controller.dart';
import 'package:material_ui/material_ui.dart';

class NoteList extends StatefulWidget {
  const new({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final con = ControllerManager.read<NoteController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: con.events.whereType<NoteControllerLoaded>(),
      builder: (context, asyncSnapshot) {
        return SliverPadding(
          padding: .all(10),
          sliver: SliverMainAxisGroup(
            slivers: [
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
        return Row(
          spacing: 10,
          children: [
            SizedBox(width: 70, height: 70, child: Placeholder()),
            Expanded(
              child: Column(
                spacing: 10,
                crossAxisAlignment: .start,
                children: [
                  Text(note.englishName),
                  Text(note.myanmarName),
                  // FilledButton(
                  //   onPressed: () {
                  //     con.delete(note);
                  //   },
                  //   child: Text('Delete'),
                  // ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        );
      },
    );
  }
}
