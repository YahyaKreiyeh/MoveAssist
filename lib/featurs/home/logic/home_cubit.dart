import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveassist/featurs/home/data/repos/moving_schedule_repo.dart';
import 'package:moveassist/featurs/home/logic/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovingScheduleRepo _movingScheduleRepo;

  HomeCubit(this._movingScheduleRepo) : super(const HomeState.initial());

  Future<void> fetchMovingSchedules() async {
    emit(const HomeState.loading());
    final result = await _movingScheduleRepo.getMovingSchedules();
    result.when(
      success: (schedules) => emit(HomeState.success(schedules)),
      failure: (error) =>
          emit(HomeState.error(error: error.apiErrorModel.message ?? '')),
    );
  }
}
