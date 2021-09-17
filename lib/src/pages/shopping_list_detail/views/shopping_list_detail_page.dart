import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:visitor_app/src/common/constants.dart';
import 'package:visitor_app/src/pages/shopping_list_detail/controllers/shopping_list_detail_controller.dart';
import 'package:visitor_app/src/utils/formatter.dart';
import 'package:visitor_app/src/widgets/rounded_button.dart';

class ShoppingListDetailsPage extends GetView<ShoppingListDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.colorBlue,
        title: Container(
          alignment: Alignment.center,
          child: Text('Weekend List'),
        ),
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
                      )
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
            MyStatefulWidget()
          ],
        ),
      ),
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

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      //headerValue: 'Panel $index',
      headerValue: 'Highlands Coffee',
      //expandedValue: 'This is item number $index',
      expandedValue: 'Trà Đào Cam Xả',
    );
  });
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<Item> _data = generateItems(2);

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
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://img.vn/uploads/danhmuc/highland-1564630760-rch7n.jpg'),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                width: 52,
              ),
              title: Text(
                item.headerValue,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  Formatter.shorten(
                      'Thương Hiệu Cà Phê Tự Hào Sinh Ra Từ Đất Việt.', 25),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
