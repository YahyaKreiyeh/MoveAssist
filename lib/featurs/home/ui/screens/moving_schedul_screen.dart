import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:moveassist/core/helpers/extensions.dart';
import 'package:moveassist/core/helpers/loading_dialog.dart';
import 'package:moveassist/core/helpers/snackbar.dart';
import 'package:moveassist/core/routing/routes.dart';
import 'package:moveassist/core/widgets/buttons/app_elevated_button.dart';
import 'package:moveassist/core/widgets/buttons/app_text_form_field.dart';
import 'package:moveassist/featurs/home/data/models/moving_schedule.dart';
import 'package:moveassist/featurs/home/logic/home_cubit.dart';
import 'package:moveassist/featurs/home/logic/moving_schedule_cubit.dart';
import 'package:moveassist/featurs/home/logic/moving_schedule_state.dart';

class MovingScheduleScreen extends StatefulWidget {
  const MovingScheduleScreen({super.key});

  @override
  MovingScheduleScreenState createState() => MovingScheduleScreenState();
}

class MovingScheduleScreenState extends State<MovingScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (date != null) {
      if (!mounted) return;
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (time != null) {
        setState(() {
          _selectedDate = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _addOrEditItem(HouseItem? item) async {
    context.pushNamed(
      Routes.addHouseItemScreen,
      arguments: item,
    );
  }

  void _deleteItem(String itemId) {
    context.read<MovingScheduleCubit>().deleteHouseItem(itemId);
    SnackBarNotifier().success(
      message: 'Item deleted',
      context: context,
    );
  }

  void _handleCreate() async {
    if (_formKey.currentState?.validate() ?? false) {
      final items = context.read<MovingScheduleCubit>().items;
      if (_selectedDate == null) {
        SnackBarNotifier().fail(
          message: 'Please pick a date and time',
          context: context,
        );
      } else if (_selectedDate!.isBefore(DateTime.now())) {
        SnackBarNotifier().fail(
          message: 'Selected date/time is in the past',
          context: context,
        );
      } else if (items.isEmpty) {
        SnackBarNotifier().fail(
          message: 'Please add at least one item',
          context: context,
        );
      } else {
        loadingDialog(context);
        await context.read<MovingScheduleCubit>().addMovingSchedule(
              _selectedDate!,
              _notesController.text,
              items,
            );
        if (!mounted) return;
        context.read<HomeCubit>().fetchMovingSchedules();
        context.popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Moving Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addOrEditItem(null),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Pick date and time'
                    : 'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(_selectedDate!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDateTime,
              ),
              AppTextFormField(
                controller: _notesController,
                hintText: 'Notes',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter notes';
                  }
                  return null;
                },
              ),
              Expanded(
                child: BlocBuilder<MovingScheduleCubit, MovingScheduleState>(
                  buildWhen: (previous, current) =>
                      previous.runtimeType != current.runtimeType,
                  builder: (context, state) {
                    if (state is Loading) {
                      return const SizedBox.shrink();
                    }
                    if (state is Success) {
                      final items = state.items ?? [];
                      if (items.isEmpty) {
                        return const Center(child: Text('No items added yet'));
                      } else {
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Dismissible(
                              key: Key(item.id),
                              onDismissed: (direction) {
                                _deleteItem(item.id);
                              },
                              background: Container(color: Colors.red),
                              child: ListTile(
                                leading: item.imageUrl.isNotEmpty
                                    ? Image.file(
                                        File(item.imageUrl),
                                        width: 50.w,
                                        height: 50.w,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(Icons.image),
                                title: Text('Name: ${item.name}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Quantity: ${item.quantity}'),
                                    Text('Description: ${item.description}'),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _addOrEditItem(item),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(child: Text('No items added yet'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppElevatedButton(
          onPressed: _handleCreate,
          text: 'Create',
        ),
      ),
    );
  }
}
