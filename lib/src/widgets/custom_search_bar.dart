import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
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
        hint: 'Search stores, facilities..',
        scrollPadding: const EdgeInsets.only(top: 10, bottom: 56),
        transitionDuration: const Duration(milliseconds: 500),
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
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                if (listLocation.isEmpty)
                  return Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text("No place found!"),
                  );
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
                    final description =
                        "Floor ${Formatter.shorten(place.floorPlan?.floorCode)} ${Formatter.distanceFormat(place.distanceTo, unit: "meter")}";

                    return Container(
                      height: 75,
                      child: TextButton(
                        onPressed: () {},
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(img),
                              ),
                            ),
                          ),
                          title: Text(title),
                          subtitle: Text(description),
                          trailing: OutlinedButton(
                            onPressed: () =>
                                controller.openDirectionMenu(place.id),
                            child: Icon(Icons.directions, size: 24),
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
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Obx(() {
      return FloatingSearchBar(
        hint: 'Search ${controller.typeSearch.value.toLowerCase()} ..',
        scrollPadding: const EdgeInsets.only(top: 10, bottom: 56),
        transitionDuration: const Duration(milliseconds: 500),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        openAxisAlignment: 0.0,
        width: screen.width * 0.95,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) => controller.search(query),
        transition: CircularFloatingSearchBarTransition(),
        backdropColor: Colors.black.withOpacity(0.1),
        automaticallyImplyBackButton: false,
        actions: [
          Container(
            height: 34,
            width: 1.3,
            color: Colors.grey.shade300,
          ),
          FloatingSearchBarAction(
            showIfOpened: false,
            child: MenuButton<String>(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
              child: _buildSelectedItem(controller.typeSearch.value),
              items: ["Coupons", "Stores", "Buildings"],
              itemBuilder: _buildMenuItem,
              toggledChild: _buildSelectedItem(controller.typeSearch.value),
              onItemSelected: (value) => controller.typeSearch.value = value,
              divider: Container(),
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
            borderRadius: BorderRadius.circular(6),
            child: _buildSearchList(),
          );
        },
      );
    });
  }

  Widget _buildSearchList() {
    return Obx(() {
      List<Object> list = [];
      final type = controller.typeSearch.value;
      if (type == "Coupons") {
        list = controller.listSearchCoupons;
      } else if (type == "Stores") {
        list = controller.listStoreSearch;
      } else if (type == "Buildings") {
        list = controller.listBuildingSearch;
      }
      if (controller.isSearching.value) return _buildLoading();
      if (list.isEmpty) return _buildNotFound();
      int count = list.length > 5 ? 5 : list.length;
      return ListView.separated(
        shrinkWrap: true,
        itemCount: count,
        separatorBuilder: (context, index) => Divider(
          indent: 15,
          endIndent: 15,
          height: 0,
          color: Colors.black38,
        ),
        itemBuilder: (context, index) => _buildSearchItem(list[index]),
      );
    });
  }

  Widget _buildSearchItem(Object? data) {
    late String img, title, description;
    late Function() navigate;
    if (data is Coupon) {
      img = data.imageUrl ?? "";
      title =
          '${Formatter.shorten(data.store?.name)} - ${Formatter.shorten(data.name)}';
      description =
          '${Formatter.shorten(data.store?.building?.name)} ${Formatter.distanceFormat(data.store?.building?.distanceTo, buildingId: data.store?.building?.id)}';
      navigate = () => controller.goToCouponDetails(data);
    } else if (data is Building) {
      img = data.imageUrl ?? "";
      title = data.name ?? '';
      description =
          '${Formatter.shorten(data.address, 20)} ${Formatter.distanceFormat(data.distanceTo, buildingId: data.id)}';
      navigate = () => Get.toNamed(Routes.buildingDetails, parameters: {
            "id": data.id.toString(),
          });
    } else if (data is Store) {
      img = data.imageUrl ?? "";
      title = data.name ?? "";
      description =
          '${Formatter.shorten(data.building?.name)} ${Formatter.distanceFormat(data.building?.distanceTo, buildingId: data.building?.id)}';
      navigate = () => Get.toNamed(Routes.storeDetails, parameters: {
            "id": data.id.toString(),
          });
    }
    return _buildSearchResult(img, title, description, () => navigate.call());
  }

  Widget _buildLoading() {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: Center(
        child: Container(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildNotFound() {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
      child: Text("No items found!"),
    );
  }

  Widget _buildMenuItem(String item) {
    return Container(
      width: 110,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
      child: Text(item),
    );
  }

  Widget _buildSelectedItem(String item) {
    return Container(
      width: 110,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget _buildSearchResult(
    String img,
    String title,
    String description,
    Function() navigateTo,
  ) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: ListTile(
        onTap: navigateTo,
        contentPadding: const EdgeInsets.all(0),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: CachedNetworkImageProvider(img),
        ),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
