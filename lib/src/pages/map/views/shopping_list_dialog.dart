import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';

class ShoppingListDialog extends GetView<MapController> {
  final Store store;

  const ShoppingListDialog({
    Key? key,
    required this.store,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: Scaffold(
        body: Container(
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [AppBoxShadow.boxShadowLight],
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    buildHeader(store),
                    ShoppingItems(
                      items: store.products,
                      onSelected: (product) => controller.onProductSelected(
                        product,
                        store.id!,
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  if (!controller.checkComplete(store.id!)) return Container();
                  return Positioned(
                    top: 5,
                    left: 44,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/check_watermark.png"),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(Store item) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(item.imageUrl!),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        height: 50,
        width: 52,
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
      trailing: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.black,
          size: 25,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}

class ShoppingItems extends StatefulWidget {
  final List<Product>? items;
  final Function(Product) onSelected;
  const ShoppingItems({
    Key? key,
    this.items,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<ShoppingItems> createState() => _ShoppingItemsState();
}

class _ShoppingItemsState extends State<ShoppingItems> {
  @override
  Widget build(BuildContext context) {
    return buildItems(widget.items);
  }

  Widget buildItems(List<Product>? items) {
    if (items == null || items.isEmpty) {
      return Text("Empty shopping list!");
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => buildItem(items[index]),
      itemCount: items.length,
    );
  }

  Widget buildItem(Product item) {
    return Container(
      height: 58,
      child: ListTile(
        title: Text(item.name!),
        leading: CustomCheckbox(
          onChange: (value) {
            widget.onSelected(item);
          },
          checked: item.checked,
        ),
        subtitle: Text(Formatter.price(item.price)),
        // trailing: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.delete_outline),
        // ),
        onTap: () {},
      ),
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  final Function(bool) onChange;
  final bool checked;
  const CustomCheckbox({
    Key? key,
    required this.onChange,
    required this.checked,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isChecked = widget.checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        checkColor: Colors.white,
        value: isChecked,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(width: 0),
        ),
        onChanged: (bool? value) {
          if (value != null) {
            setState(() {
              isChecked = value;
            });
            widget.onChange(value);
          }
        },
      ),
    );
  }
}
