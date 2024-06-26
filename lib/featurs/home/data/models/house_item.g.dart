// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseItem _$HouseItemFromJson(Map<String, dynamic> json) => HouseItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$HouseItemToJson(HouseItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
