import 'package:dual_store/dual_store.dart';
import 'package:uuid/v4.dart';

class Note extends IDuModel {
  Note({
    required this.id,
    required this.englishName,
    required this.myanmarName,
    required this.description,
    required this.categoryId,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
    this.formContent = '',
  });

  final String id;
  final String englishName;
  final String myanmarName;
  final String description;
  final String categoryId;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;
  String formContent;

  factory createEmpty() {
    return .new(
      id: UuidV4().generate(),
      englishName: '',
      myanmarName: '',
      description: '',
      categoryId: '',
      tags: [],
      createdAt: .now(),
      updatedAt: .now(),
      isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'englishName': englishName,
      'myanmarName': myanmarName,
      'description': description,
      'categoryId': categoryId,
      'tags': tags,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isFavorite': isFavorite,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      englishName: json['englishName'],
      myanmarName: json['myanmarName'],
      description: json['description'],
      categoryId: json['categoryId'],
      tags: List<String>.from(json['tags']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
      isFavorite: json['isFavorite'],
    );
  }

  Note copyWith({
    String? id,
    String? englishName,
    String? myanmarName,
    String? description,
    String? categoryId,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) {
    return Note(
      id: id ?? this.id,
      englishName: englishName ?? this.englishName,
      myanmarName: myanmarName ?? this.myanmarName,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
