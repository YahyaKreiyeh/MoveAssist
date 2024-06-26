import 'package:json_annotation/json_annotation.dart';

part 'house_item.g.dart';

@JsonSerializable()
class HouseItem {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  HouseItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory HouseItem.fromJson(Map<String, dynamic> json) =>
      _$HouseItemFromJson(json);
  Map<String, dynamic> toJson() => _$HouseItemToJson(this);
}
