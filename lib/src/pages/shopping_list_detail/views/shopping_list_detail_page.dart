import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/pages/shopping_list_detail/controllers/shopping_list_detail_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/widgets/rounded_button.dart';

class ShoppingListDetailsPage extends GetView<ShoppingListDetailController> {
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
                  children: [
                    SizedBox(
                      width: 150,
                    ),
                    Text("Ongoing",
                        style: TextStyle(
                            fontSize: 1,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 110,
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
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ShoppingItems(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primary,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 140,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                      color: Colors.purpleAccent, width: 2)),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Login',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 220,
                    ),
                    Text('Forgot Password ?',
                        style:
                            TextStyle(fontSize: 15, color: AppColors.primary)),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  'You can also login with these methods',
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(0.8)),
                )),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'You agree ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      TextSpan(
                        text: 'User Agreement ',
                        style: TextStyle(
                            fontSize: 14, color: Colors.blue.withOpacity(0.8)),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                            fontSize: 14, color: Colors.black.withOpacity(0.8)),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                            fontSize: 14, color: Colors.blue.withOpacity(0.8)),
                      ),
                    ]),
                  ),
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
            return Slidable(
              actionPane: SlidableScrollActionPane(),
              secondaryActions: <Widget>[
                Transform.translate(
                  offset: Offset(-4, 0),
                  child: Container(
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
                                  style: TextStyle(
                                      color: AppColors.primary, fontSize: 18),
                                ),
                                onPressed: () {},
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
              child: ListTile(
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
