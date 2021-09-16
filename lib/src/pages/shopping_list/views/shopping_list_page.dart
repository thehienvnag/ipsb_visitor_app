import 'package:visitor_app/src/common/constants.dart';
import 'package:visitor_app/src/pages/shopping_list/controllers/shopping_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShoppingListPage extends GetView<ShoppingListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.colorBlue,
        title: Container(
          alignment: Alignment.center,
          child: Text('Shopping List'),
        ),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ...listItem([1, 2, 3, 4, 5, 6, 7], context),
          SizedBox(
            height: 50,
          )
        ]),
      ),
    );
  }

  List<Widget> listItem(List<int> list, BuildContext context) {
    if (list.isEmpty) {
      return [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, right: 20),
                height: 200,
                width: 210,
                child: Image.network(
                    'https://image.flaticon.com/icons/png/512/891/891462.png'),
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
        ),
      ];
    }
    return list.map((e) => shoppingItem(e, context)).toList();
  }

  Widget shoppingItem(int element, BuildContext context) {
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
        // IconSlideAction(
        //   caption: 'Delete',
        //   //color: AppColors.primary,
        //   icon: Icons.delete,
        //   onTap: () => print('Delete'),
        // )
      ],
      actionExtentRatio: 0.15,
      child: Container(
        margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
        padding: const EdgeInsets.only(
          top: 10,
          left: 15,
          right: 15,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          //border: Border.all(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  height: 52,
                  width: 50,
                  child: Image.network(
                      'https://image.flaticon.com/icons/png/512/2331/2331970.png'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekend List',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Vincom Thủ Đức',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Shopping Date: 8/11/2021',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.black26, width: 1),
                shape: BoxShape.circle,
                color: Color(0xff64B0E7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}