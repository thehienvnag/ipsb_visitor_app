import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/pages/shopping_list_detail/controllers/shopping_list_detail_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/widgets/rounded_button.dart';

class View2 extends GetView<ShoppingListDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 30,
        width: 30,
        child: ElevatedButton(
          onPressed: () {
            showLoginBottomSheet();
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
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
          'Weekend List',
          style: TextStyle(color: Colors.black),
        ),
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
                          onPressed: () {},
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vincom Thủ Đức',
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.directions,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: ShoppingItems(),
            )
          ],
        ),
      ),
    );
  }

  void showLoginBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Ongoing shopping',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            letterSpacing: 1,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: RoundedButton(
                            radius: 40,
                            color: Colors.grey[200],
                            onPressed: () {},
                            icon: Icon(
                              Icons.directions,
                              color: AppColors.primary,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: ShoppingItems(),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierColor: Colors.transparent,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(width: 0.5, color: Colors.grey),
      ),
      enableDrag: false,
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Store> generateItems(int numberOfItems) {
  return List<Store>.generate(numberOfItems, (int index) {
    return Store(
      name: "Highland Coffee",
      description: "Thương hiệu cafe chất lượng cao",
      imageUrl: 'https://img.vn/uploads/danhmuc/highland-1564630760-rch7n.jpg',
      products: [
        Product(name: "Trà đào cam sả", price: 40000),
        Product(name: "Trà đào cam sả", price: 40000),
        Product(name: "Trà đào cam sả", price: 40000),
      ],
    );
  });
}

class ShoppingItems extends StatefulWidget {
  const ShoppingItems({Key? key}) : super(key: key);

  @override
  State<ShoppingItems> createState() => _ShoppingItemsState();
}

class _ShoppingItemsState extends State<ShoppingItems> {
  final List<Store> _data = generateItems(2);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Store item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
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

  Widget buildItem(Product item) {
    return ListTile(
      title: Text(item.name!),
      leading: MyStatefulWidget(),
      subtitle: Text(Formatter.price(item.price)),
      trailing: const Icon(Icons.delete),
      onTap: () {},
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
