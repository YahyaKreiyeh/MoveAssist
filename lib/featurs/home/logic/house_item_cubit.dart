import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moveassist/featurs/home/data/repos/house_Item_repo.dart';
import 'package:moveassist/featurs/home/logic/house_item_state.dart';

class HouseItemCubit extends Cubit<HouseItemState> {
  final HouseItemRepo _houseItemRepo;

  HouseItemCubit(this._houseItemRepo) : super(const HouseItemState.initial());

  Future addHouseItem(String name, String description, XFile image) async {
    emit(const HouseItemState.loading());
    final result = await _houseItemRepo.addHouseItem(name, description, image);
    print('res$result');
    result.when(
      success: (houseItem) => emit(HouseItemState.success([houseItem])),
      failure: (error) =>
          emit(HouseItemState.error(error: error.apiErrorModel.message ?? '')),
    );
  }

  void fetchHouseItems() async {
    emit(const HouseItemState.loading());
    final result = await _houseItemRepo.getHouseItems();
    print(result);
    result.when(
      success: (houseItems) => emit(HouseItemState.success(houseItems)),
      failure: (error) =>
          emit(HouseItemState.error(error: error.apiErrorModel.message ?? '')),
    );
  }
}
