import 'package:json_annotation/json_annotation.dart';

part 'moving_schedule.g.dart';

@JsonSerializable()
class MovingSchedule {
  final String id;
  final DateTime date;
  final String notes;
  final List<HouseItem> items;

  MovingSchedule({
    required this.id,
    required this.date,
    required this.notes,
    required this.items,
  });

  factory MovingSchedule.fromJson(Map<String, dynamic> json) =>
      _$MovingScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$MovingScheduleToJson(this);
}

@JsonSerializable()
class HouseItem {
  final String id;
  final String name;
  final int quantity;
  final String description;
  final String imageUrl;

  HouseItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.description,
    required this.imageUrl,
  });

  factory HouseItem.fromJson(Map<String, dynamic> json) =>
      _$HouseItemFromJson(json);

  Map<String, dynamic> toJson() => _$HouseItemToJson(this);
}
