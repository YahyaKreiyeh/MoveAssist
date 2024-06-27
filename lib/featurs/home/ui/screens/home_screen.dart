import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveassist/core/helpers/extensions.dart';
import 'package:moveassist/core/routing/routes.dart';
import 'package:moveassist/core/utils/constants/colors.dart';
import 'package:moveassist/core/widgets/loading_indicator.dart';
import 'package:moveassist/featurs/home/logic/home_cubit.dart';
import 'package:moveassist/featurs/home/logic/home_state.dart';
import 'package:moveassist/featurs/home/ui/widgets/moving_shcedule_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Moving Schedules'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No schedules found')),
            loading: () => const Center(child: LoadingIndicator()),
            success: (schedules) => schedules.isEmpty
                ? const Center(child: Text('No schedules found'))
                : ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];
                      return MovingScheduleListTile(
                        schedule: schedule,
                      );
                    },
                  ),
            error: (error) => Center(child: Text(error)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsManager.primary,
        foregroundColor: ColorsManager.white,
        onPressed: () => context.pushNamed(Routes.movingScheduleScreen),
        child: const Icon(Icons.add),
      ),
    );
  }
}
