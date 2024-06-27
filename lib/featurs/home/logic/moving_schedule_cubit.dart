import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveassist/featurs/home/data/models/moving_schedule.dart';
import 'package:moveassist/featurs/home/data/repos/moving_schedule_repo.dart';
import 'package:moveassist/featurs/home/logic/moving_schedule_state.dart';
import 'package:workmanager/workmanager.dart';

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
        emit(MovingScheduleState.success(items));
        await scheduleMoveNotification(date, schedule.id);
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

Future<void> scheduleMoveNotification(DateTime moveTime, String moveId) async {
  await Workmanager().registerOneOffTask(
    "move_notification_$moveId",
    "move_notification_task",
    inputData: {
      'moveId': moveId,
      'moveTime': moveTime.toIso8601String(),
    },
    initialDelay: Duration(
      milliseconds:
          moveTime.subtract(const Duration(hours: 1)).millisecondsSinceEpoch -
              DateTime.now().millisecondsSinceEpoch,
    ),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
}
