import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveassist/core/helpers/extensions.dart';
import 'package:moveassist/core/routing/routes.dart';
import 'package:moveassist/featurs/home/logic/house_item_cubit.dart';
import 'package:moveassist/featurs/home/logic/house_item_state.dart';

class HouseItemsScreen extends StatelessWidget {
  const HouseItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushNamed(
              Routes.addHouseItemsScreen,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HouseItemCubit, HouseItemState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No items found')),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (houseItems) => ListView.builder(
              itemCount: houseItems.length,
              itemBuilder: (context, index) {
                final item = houseItems[index];
                return ListTile(
                  leading: Image.file(File(item.imageUrl)),
                  title: Text(item.name),
                  subtitle: Text(item.description),
                );
              },
            ),
            error: (error) => Center(child: Text(error)),
          );
        },
      ),
    );
  }
}
