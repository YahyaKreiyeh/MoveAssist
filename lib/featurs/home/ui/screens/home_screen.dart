import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moveassist/core/helpers/extensions.dart';
import 'package:moveassist/core/routing/routes.dart';
import 'package:moveassist/core/widgets/loading_indicator.dart';
import 'package:moveassist/featurs/home/logic/home_cubit.dart';
import 'package:moveassist/featurs/home/logic/home_state.dart';

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
                      return Dismissible(
                        key: Key(schedule.id),
                        onDismissed: (direction) async {
                          await context
                              .read<HomeCubit>()
                              .deleteMovingSchedule(schedule.id);
                        },
                        background: Container(color: Colors.red),
                        child: ListTile(
                          title: Text(
                              'Schedule for ${DateFormat('yyyy-MM-dd HH:mm:ss').format(schedule.date)}'),
                          subtitle: Text(schedule.notes),
                        ),
                      );
                    },
                  ),
            error: (error) => Center(child: Text(error)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(Routes.movingScheduleScreen),
        child: const Icon(Icons.add),
      ),
    );
  }
}
