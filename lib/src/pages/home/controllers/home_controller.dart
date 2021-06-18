import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/home/views/home_page.dart';

final listFloorPlanFinal = [
  Floor(name: "Chọn tầng", floorNum: 0),
  Floor(name: "Tầng 1", floorNum: 1),
  Floor(name: "Tầng 2", floorNum: 2),
  Floor(name: "Tầng 3", floorNum: 3),
  Floor(name: "Tầng 4", floorNum: 4),
  Floor(name: "Tầng 5", floorNum: 5),
  Floor(name: "Tầng 5", floorNum: 6),
];

class HomeController extends GetxController {
  var counter = 0.obs;

  /// increaseCounter var
  void increaseCounter() {
    counter.value++;
  }

  /// [searchValue] for home screen
  var searchValue = "".obs;

  /// change search value with String [value]
  void changeSearchValue(String value) {
    searchValue.value = value;
  }

  ///  list floor plan data
  var listFloorPlan = listFloorPlanFinal.obs;
  /// Get selected of floor
  var selectedFloor = listFloorPlanFinal[0].obs;
  /// Change selected of floor
  void changeSelectedFloor(Floor? floor){
    selectedFloor.value = floor!;
  }
}
