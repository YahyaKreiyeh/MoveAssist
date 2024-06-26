// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moving_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovingSchedule _$MovingScheduleFromJson(Map<String, dynamic> json) =>
    MovingSchedule(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => HouseItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovingScheduleToJson(MovingSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'notes': instance.notes,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

HouseItem _$HouseItemFromJson(Map<String, dynamic> json) => HouseItem(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$HouseItemToJson(HouseItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
