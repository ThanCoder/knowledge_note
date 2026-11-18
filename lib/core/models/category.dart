import 'package:dual_store/dual_store.dart';

class Category extends IDuModel {
  final String id;
  final String name;
  final String myanmarName;
  final String? parentId;
  final String? icon;
  final int colorValue;

  Category({
    required this.id,
    required this.name,
    required this.myanmarName,
    this.parentId,
    this.icon,
    required this.colorValue,
  });
}
