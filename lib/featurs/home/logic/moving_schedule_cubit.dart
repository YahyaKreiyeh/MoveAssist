import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveassist/featurs/home/data/models/moving_schedule.dart';
import 'package:moveassist/featurs/home/data/repos/moving_schedule_repo.dart';
import 'package:moveassist/featurs/home/logic/moving_schedule_state.dart';

class MovingScheduleCubit extends Cubit<MovingScheduleState> {
  final MovingScheduleRepo _movingScheduleRepo;
  List<HouseItem> items = [];

  MovingScheduleCubit(this._movingScheduleRepo)
      : super(const MovingScheduleState.initial());

  Future<void> addMovingSchedule(
    DateTime date,
    String notes,
    List<HouseItem> items,
  ) async {
    emit(const MovingScheduleState.loading());
    final result =
        await _movingScheduleRepo.addMovingSchedule(date, notes, items);
    result.when(
      success: (schedule) async {
        items = [];
        emit(MovingScheduleState.success(items));
      },
      failure: (error) => emit(
          MovingScheduleState.error(error: error.apiErrorModel.message ?? '')),
    );
  }

  void addOrUpdateHouseItem(HouseItem houseItem) {
    emit(const MovingScheduleState.loading());
    final index = items.indexWhere((item) => item.id == houseItem.id);
    if (index != -1) {
      items[index] = houseItem;
    } else {
      items.add(houseItem);
    }
    emit(MovingScheduleState.success(List.from(items)));
  }

  void deleteHouseItem(String itemId) {
    items.removeWhere((item) => item.id == itemId);
    emit(MovingScheduleState.success(List.from(items)));
  }
}
