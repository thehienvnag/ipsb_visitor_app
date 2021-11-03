import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/pages/home/controllers/home_controller.dart';
import 'package:menu_button/menu_button.dart';

import 'custom_menu_button.dart';

class MapSearchBar extends GetView<MapController> {
  final List<FloorPlan>? items;
  final FloorPlan? selected;
  const MapSearchBar({
    Key? key,
    this.items,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 48),
      child: FloatingSearchBar(
        hint: 'Tìm cửa hàng, địa điểm...',
        scrollPadding: const EdgeInsets.only(top: 10, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        openAxisAlignment: 0.0,
        width: screenSize.width * 0.95,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {
          controller.searchLocations(query);
        },
        transition: CircularFloatingSearchBarTransition(),
        backdropColor: Colors.black.withOpacity(0.1),
        automaticallyImplyBackButton: false,
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
              child: Obx(() {
                final listLocation = controller.searchLocationList;
                if (controller.isSearchingLocationList.value)
                  return Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Center(child: CircularProgressIndicator()));
                if (listLocation.isEmpty)
                  return Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text("No place found!"));
                int count = listLocation.length > 6 ? 6 : listLocation.length;
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: count,
                  separatorBuilder: (context, index) => Divider(
                    indent: 15,
                    endIndent: 15,
                    height: 0,
                    color: Colors.black38,
                  ),
                  itemBuilder: (context, index) {
                    final place = listLocation[index];
                    final img = place.store?.imageUrl ??
                        place.locationType?.imageUrl ??
                        "";
                    final title = Formatter.shorten(
                        place.store?.name ?? place.locationType?.name);
                    final description = Formatter.shorten(
                        place.store?.description ??
                            place.locationType?.description);
                    final floorCode =
                        Formatter.shorten(place.floorPlan?.floorCode);
                    return Container(
                      height: 75,
                      child: TextButton(
                        onPressed: () {},
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(img),
                          ),
                          title: Text(title + " - Tầng " + floorCode),
                          subtitle: Text(description),
                          trailing: OutlinedButton(
                            onPressed: () =>
                                controller.startShowDirection(place.id),
                            child: Icon(
                              Icons.directions,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

class HomeSearchBar extends GetView<HomeController> {
  final String buildingName;
  HomeSearchBar({
    required this.buildingName,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return FloatingSearchBar(
      hint: 'Search coupons..',
      scrollPadding: const EdgeInsets.only(top: 10, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      openAxisAlignment: 0.0,
      width: screen.width * 0.95,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) => controller.searchCoupons(query),
      transition: CircularFloatingSearchBarTransition(),
      backdropColor: Colors.black.withOpacity(0.1),
      automaticallyImplyBackButton: false,
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: MenuButton<String>(
            selectedItem: "Hello 1",
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text('Products'),
            ),
            items: ["Coupons", "Products", "Stores"],
            itemBuilder: (value) => Container(
              height: 40,
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
              child: Text(value),
            ),
            toggledChild: Container(
              padding: const EdgeInsets.all(10),
              child: Text('Products'),
            ),
            onItemSelected: (value) {},
            // onMenuButtonToggle: (bool isToggle) {},
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
            child: Obx(() {
              final listCoupons = controller.listSearchCoupons;
              if (controller.isSearching.value)
                return Container(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Center(child: CircularProgressIndicator()));
              if (listCoupons.isEmpty)
                return Container(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 20),
                    child: Text("No coupons found!"));
              int count = listCoupons.length > 5 ? 5 : listCoupons.length;
              return ListView.separated(
                shrinkWrap: true,
                itemCount: count,
                separatorBuilder: (context, index) => Divider(
                  indent: 15,
                  endIndent: 15,
                  height: 0,
                  color: Colors.black38,
                ),
                itemBuilder: (context, index) {
                  final coupon = listCoupons[index];
                  final img = coupon.imageUrl ?? "";
                  final title = Formatter.shorten(coupon.store?.name) +
                      " - " +
                      Formatter.shorten(coupon.name);
                  final description = Formatter.shorten(coupon.description);
                  return Container(
                    height: 85,
                    child: TextButton(
                      onPressed: () {},
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(img),
                        ),
                        title: Text(title),
                        subtitle: Text(description),
                        trailing: OutlinedButton.icon(
                          onPressed: () => controller.goToCouponDetails(coupon),
                          icon: Icon(
                            Icons.local_activity,
                            size: 24,
                          ),
                          label: Text("Chi Tiết"),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }
}
