import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:knowledge_note/ui/index.dart';
import 'package:material_ui/material_ui.dart';

class NoteImageChooser extends StatefulWidget {
  const new({
    super.key,
    required this.bytes,
    required this.onDeleted,
    required this.onUpdated,
    required this.onAdded,
  });
  final Uint8List? bytes;
  final void Function(Uint8List bytes) onUpdated;
  final void Function(Uint8List bytes) onAdded;
  final void Function() onDeleted;

  @override
  State<NoteImageChooser> createState() => _NoteImageChooserState();
}

class _NoteImageChooserState extends State<NoteImageChooser> {
  late Uint8List? bytes;
  @override
  void initState() {
    bytes = widget.bytes;
    super.initState();
  }

  final picker = ImagePicker();

  void _chooseImage() async {
    final res = await picker.pickImage(source: .gallery);

    if (res == null) return;
    bytes = await res.readAsBytes();
    widget.onAdded(bytes!);
    if (!mounted) return;
    setState(() {});
  }

  void _replaceImage() async {
    final res = await picker.pickImage(source: .gallery);

    if (res == null) return;
    bytes = await res.readAsBytes();
    widget.onUpdated(bytes!);
    if (!mounted) return;
    setState(() {});
  }

  void _delImage() async {
    bytes = null;
    widget.onDeleted();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SizedBox(
          width: 130,
          height: 130,
          child: ClipRRect(borderRadius: .circular(20), child: _img),
        ),
        Wrap(
          runSpacing: 5,
          spacing: 5,
          alignment: .center,
          children: [
            if (bytes == null)
              FilledButton(onPressed: _chooseImage, child: Text('New Image')),
            if (bytes != null)
              FilledButton(
                onPressed: _replaceImage,
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.secondary,
                  foregroundColor: context.colorScheme.onSecondary,
                ),
                child: Text('Replace Image'),
              ),
            if (bytes != null)
              FilledButton(
                onPressed: _delImage,
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.error,
                  foregroundColor: context.colorScheme.onError,
                ),
                child: Text('Delete Image'),
              ),
          ],
        ),
      ],
    );
  }

  Widget get _img {
    if (bytes == null) {
      return _defImg;
    }
    return Image.memory(
      bytes!,
      errorBuilder: (context, error, stackTrace) => _defImg,
    );
  }

  Widget get _defImg {
    return Icon(Icons.image_not_supported_outlined, size: 80);
  }
}
