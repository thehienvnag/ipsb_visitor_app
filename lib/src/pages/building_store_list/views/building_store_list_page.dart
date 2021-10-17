import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:ipsb_visitor_app/src/pages/building_store_list/controllers/building_store_controller.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';

class BuildingStorePage extends GetView<BuildingStoreController> {
  final SharedStates sharedData = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back(closeOverlays: true);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Column(
          children: [
            Text(
              'Danh sách thương hiệu',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              height: 50,
              child: Obx(() {
                final listCate = controller.listIndex;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: listCate.length,
                  itemBuilder: (context, index) {
                    var category = listCate[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 5, right: 10),
                      child: ChoiceChip(
                        label: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.store,
                                color: Colors.deepOrangeAccent,
                              ),
                              Text(
                                '${category.category?.name ?? ''}',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.white,
                        selectedColor: Color(0xff9EFFF9),
                        selected: category.select!,
                        onSelected: (value) {
                          controller.changeSelected(category.category?.id);
                          controller.getStoreByCategory(
                              category.select!, category.id!);
                        },
                      ),
                    );
                  },
                );
              })),
          Obx(() {
            var listStore = controller.listStoreByCategory;
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Container(
                  height: screenSize.height * 0.76,
                  child: GridView.builder(
                    addSemanticIndexes: true,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // num row
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 2, // height of Card
                    ),
                    itemCount: listStore.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final store = listStore[index];
                      return GestureDetector(
                        onTap: () => controller.goToStoreDetails(store.id),
                        child: Card(
                          child: ListTile(
                            leading: Image.network(
                              store.imageUrl ?? "",
                              width: 50,
                            ),
                            title: Text(Formatter.shorten(store.name, 10)),
                            subtitle: Text(Formatter.shorten("3 coupons", 10)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
