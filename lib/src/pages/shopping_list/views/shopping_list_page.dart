import 'package:cached_network_image/cached_network_image.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/shopping_list.dart';
import 'package:ipsb_visitor_app/src/pages/shopping_list/controllers/shopping_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_bottom_bar.dart';
import 'package:ipsb_visitor_app/src/widgets/user_welcome.dart';

class ShoppingListPage extends GetView<ShoppingListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Shopping List',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 5),
            child: ProfileIcon(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.add,
        ),
        onPressed: () => controller.createShoppingList(),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          listItem(),
          SizedBox(
            height: 100,
          )
        ]),
      ),
      bottomNavigationBar: CustomBottombar(),
    );
  }

  Widget listItem() {
    return Obx(() {
      if (AuthServices.userLoggedIn.value.id == null) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, right: 20),
                height: 200,
                width: 200,
                child: Image.asset(
                    ConstImg.emptyList),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  'Shopping list is not available',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: 320,
                child: Text(
                  'Come back to check after login in your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      final list = controller.shoppingLists;
      if (controller.loading.value) {
        return Container(
          margin: const EdgeInsets.only(top: 200),
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (list.isEmpty) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, right: 20),
                height: 200,
                width: 210,
                child: Image.asset(
                    ConstImg.emptyList),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  'Your List is Empty',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: 320,
                child: Text(
                  'Create list and add them to your trolley for an easier shopping experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => shoppingItem(list[index], context),
        itemCount: list.length,
      );
    });
  }

  Widget shoppingItem(ShoppingList element, BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      secondaryActions: <Widget>[
        Transform.translate(
          offset: Offset(-4, 0),
          child: Container(
            margin: EdgeInsets.only(top: 20, right: 20),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Delete?'),
                    content: Text('Are you sure to delete?'),
                    actions: [
                      TextButton(
                        child: Text(
                          'No',
                          style: TextStyle(
                              color: AppColors.colorBlue, fontSize: 18),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Yes',
                          style:
                              TextStyle(color: AppColors.primary, fontSize: 18),
                        ),
                        onPressed: () =>
                            controller.deleteShoppingList(element.id),
                      ),
                    ],
                  ),
                );
              },
              icon: Container(
                child: Icon(
                  Icons.delete,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
      actionExtentRatio: 0.15,
      child: Container(
        margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
        padding: const EdgeInsets.only(
          top: 6,
          left: 15,
          right: 15,
          bottom: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          //border: Border.all(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(
                    Routes.shoppingListDetail,
                    parameters: {
                      "shoppingListId": element.id.toString(),
                    },
                  ),
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 50,
                    width: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: Utils.resolveDecoImg(element.building?.imageUrl!),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      element.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      Formatter.shorten(element.building?.name, 20),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              Formatter.date(element.shoppingDate),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
