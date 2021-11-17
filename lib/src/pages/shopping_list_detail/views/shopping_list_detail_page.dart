import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/pages/shopping_list_detail/controllers/shopping_list_detail_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';
import 'package:ipsb_visitor_app/src/widgets/rounded_button.dart';

class ShoppingListDetailsPage extends GetView<ShoppingListDetailController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.shoppingListDetails.value.name == null &&
          !controller.isLoading.value) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.chevron_left_outlined,
                color: Colors.black,
                size: 40,
              ),
            ),
            title: Text(
              "Removed",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.white),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40, right: 20),
                  height: 200,
                  width: 200,
                  child: Image.asset(ConstImg.error),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'Oops! An error occurred',
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
                    'Shopping list may have been removed',
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
          ),
        );
      }
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.chevron_left_outlined,
              color: Colors.black,
              size: 40,
            ),
          ),
          title: Obx(() {
            return Text(
              controller.shoppingListDetails.value.name ?? "Default",
              style: TextStyle(color: Colors.black),
            );
          }),
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 20,
                  right: 20,
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 1),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add New Product',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          child: FloatingActionButton(
                            onPressed: () => controller.createShoppingItem(),
                            backgroundColor: AppColors.primary,
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'You Can Add New Product in here.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  if (!controller.checkDataPresent()) {
                    return Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: CircularProgressIndicator(),
                    );
                  }
                  final details = controller.shoppingListDetails.value;
                  if (details.shoppingItems!.isEmpty) {
                    return Container();
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            details.name!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              letterSpacing: 1,
                              color: Colors.black,
                            ),
                          ),
                          RoundedButton(
                            radius: 45,
                            color: Colors.grey[200],
                            onPressed: () {
                              controller.startShopping(context);
                            },
                            icon: Icon(
                              Icons.directions,
                              color: AppColors.primary,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Obx(() {
                  if (!controller.checkDataPresent()) {
                    return Container();
                  }
                  final shoppingListDetails =
                      controller.shoppingListDetails.value;
                  final stores = shoppingListDetails.getListStores();
                  return ShoppingItems(
                    stores: stores,
                    removeCallback: controller.deleteShoppingItem,
                    updateCallback: controller.updateShoppingItem,
                  );
                }),
              )
            ],
          ),
        ),
      );
    });
  }
}

class ShoppingItems extends StatefulWidget {
  final List<Store>? stores;
  final Function(List<int>) removeCallback;
  final Function(int, String) updateCallback;

  const ShoppingItems({
    Key? key,
    this.stores,
    required this.removeCallback,
    required this.updateCallback,
  }) : super(key: key);

  @override
  State<ShoppingItems> createState() => _ShoppingItemsState();
}

class _ShoppingItemsState extends State<ShoppingItems> {
  String? note;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    if (widget.stores == null) {
      return Container();
    }
    return ExpansionPanelList(
      elevation: 0,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.stores![index].isExpanded = !isExpanded;
        });
      },
      children: widget.stores!.map<ExpansionPanel>((Store item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Slidable(
              actionPane: SlidableScrollActionPane(),
              secondaryActions: <Widget>[
                Transform.translate(
                  offset: Offset(-4, 0),
                  child: Container(
                    child: IconButton(
                      onPressed: () {
                        showDeleteDialog(item.products!
                            .map((e) => e.shoppingItemId!)
                            .toList());
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
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl!),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 80,
                  width: 80,
                ),
                title: Text(
                  item.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Formatter.shorten(item.description, 25),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          },
          body: Column(
            children: [
              ...item.products?.map((e) => buildItem(e)).toList() ?? []
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  void showDeleteDialog(List<int> shoppingItemIds) {
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
              style: TextStyle(color: AppColors.colorBlue, fontSize: 18),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text(
              'Yes',
              style: TextStyle(color: AppColors.primary, fontSize: 18),
            ),
            onPressed: () => widget.removeCallback(shoppingItemIds),
          ),
        ],
      ),
    );
  }

  Widget buildItem(Product item) {
    return ListTile(
      leading: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: Utils.resolveDecoImg(item.imageUrl),
        ),
      ),
      title: Text(
        Formatter.shorten(item.name, 20),
        style: item.status == "Inactive"
            ? TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: item.note != null && item.note!.isNotEmpty
          ? Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.notes,
                    color: Colors.grey,
                  ),
                ),
                Text(item.note!),
              ],
            )
          : Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ),
                Text("Enter your note"),
              ],
            ),
      trailing: IconButton(
        onPressed: () => showDeleteDialog([item.shoppingItemId!]),
        icon: Icon(
          Icons.delete_outline,
          color: item.status == "Inactive" ? Colors.redAccent : null,
        ),
      ),
      onTap: () => showUpdateDialog(item),
    );
  }

  void showUpdateDialog(Product product) {
    setState(() {
      note = null;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          height: 165,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              ListTile(
                leading: Image.network(product.imageUrl!),
                title: Text(product.name!),
                onTap: () {},
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                onChanged: (val) {
                  print(val);
                  setState(() {
                    note = val;
                  });
                },
                maxLines: 3,
                initialValue: product.note,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.only(top: 8, left: 10),
                  hintText: 'Enter note for shopping item',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.colorBlue, fontSize: 18),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(color: AppColors.primary, fontSize: 18),
            ),
            onPressed: () => widget.updateCallback(
              product.shoppingItemId!,
              note ?? "",
            ),
          ),
        ],
      ),
    );
  }
}
