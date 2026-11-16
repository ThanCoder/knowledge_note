import 'package:dual_store/dual_store.dart';
import 'package:uuid/v4.dart';

class KnowledgeNote extends IDuModel {
  KnowledgeNote({
    required this.id,
    required this.englishName,
    required this.myanmarName,
    required this.description,
    required this.content,
    required this.categoryId,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
  });

  final String id;
  final String englishName;
  final String myanmarName;
  final String description;
  final String content;
  final String categoryId;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;

  factory createEmpty() {
    return .new(
      id: UuidV4().generate(),
      englishName: '',
      myanmarName: '',
      description: '',
      content: '',
      categoryId: '',
      tags: [],
      createdAt: .now(),
      updatedAt: .now(),
      isFavorite: false,
    );
  }

  KnowledgeNote copyWith({
    String? id,
    String? englishName,
    String? myanmarName,
    String? description,
    String? content,
    String? categoryId,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) {
    return KnowledgeNote(
      id: id ?? this.id,
      englishName: englishName ?? this.englishName,
      myanmarName: myanmarName ?? this.myanmarName,
      description: description ?? this.description,
      content: content ?? this.content,
      categoryId: categoryId ?? this.categoryId,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'englishName': englishName,
      'myanmarName': myanmarName,
      'description': description,
      'content': content,
      'categoryId': categoryId,
      'tags': tags,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isFavorite': isFavorite,
    };
  }

  factory KnowledgeNote.fromJson(Map<String, dynamic> json) {
    return KnowledgeNote(
      id: json['id'],
      englishName: json['englishName'],
      myanmarName: json['myanmarName'],
      description: json['description'],
      content: json['content'],
      categoryId: json['categoryId'],
      tags: List<String>.from(json['tags']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
      isFavorite: json['isFavorite'],
    );
  }
}
