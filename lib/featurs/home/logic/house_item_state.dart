import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moveassist/featurs/home/data/models/house_item.dart';

part 'house_item_state.freezed.dart';

@freezed
class HouseItemState with _$HouseItemState {
  const factory HouseItemState.initial() = _Initial;
  const factory HouseItemState.loading() = Loading;
  const factory HouseItemState.success(List<HouseItem> houseItems) = Success;
  const factory HouseItemState.error({required String error}) = Error;
}
