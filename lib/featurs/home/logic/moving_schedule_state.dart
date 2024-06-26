import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moveassist/featurs/home/data/models/moving_schedule.dart';

part 'moving_schedule_state.freezed.dart';

@freezed
class MovingScheduleState with _$MovingScheduleState {
  const factory MovingScheduleState.initial() = _Initial;

  const factory MovingScheduleState.loading() = Loading;

  const factory MovingScheduleState.success(List<HouseItem>? items) = Success;

  const factory MovingScheduleState.error({required String error}) = Error;
}
