import 'package:dual_store/dual_store.dart';

class NoteImg extends IDuModel {
  final String noteId;

  NoteImg({required this.noteId});

  Map<String, dynamic> toJson() {
    return {'noteId': noteId};
  }

  factory NoteImg.fromJson(Map<String, dynamic> json) {
    return NoteImg(noteId: json['noteId']);
  }

  NoteImg copyWith({String? noteId}) {
    return NoteImg(noteId: noteId ?? this.noteId);
  }
}
