import 'package:flutter/material.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:indoor_positioning_visitor/src/models/floor_plan.dart';

import 'custom_menu_button.dart';

class MapSearchBar extends StatelessWidget {
  final List<FloorPlan>? items;
  final FloorPlan? selected;
  const MapSearchBar({
    Key? key,
    this.items,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: FloatingSearchBar(
        hint: 'Tìm kiếm cửa hàng, địa điểm...',
        scrollPadding: const EdgeInsets.only(top: 10, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        openAxisAlignment: 0.0,
        width: 390,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {},
        transition: CircularFloatingSearchBarTransition(),
        backdropColor: Colors.black.withOpacity(0.1),
        automaticallyImplyBackButton: true,
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CustomMenuButton(
              items: items,
              selected: selected,
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return Material(
            color: Colors.white,
            elevation: 4.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 4,
                separatorBuilder: (context, index) => Divider(
                  indent: 15,
                  endIndent: 15,
                  height: 0,
                  color: Colors.black38,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    height: 75,
                    child: TextButton(
                      onPressed: () {},
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ConstImg.stairCase),
                            ),
                          ),
                        ),
                        title: Text('Restroom'),
                        subtitle: Text('Restroom tại tầng L1'),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(right: 10),
      height: 47,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        // border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            // spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 230,
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_outlined),
                hintText: 'Tìm kiếm ưu đãi',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 10, left: 10),
              ),
              cursorHeight: 24,
            ),
          ),
          Row(
            children: [
              Container(
                height: 34,
                width: 1.3,
                color: Colors.grey.shade300,
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, right: 10),
                child: Icon(Icons.apartment_rounded, color: Colors.black45),
              ),
              Text(
                'Vincomp Lê...',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
