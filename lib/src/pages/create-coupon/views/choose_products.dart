import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/product.dart';
import 'package:indoor_positioning_visitor/src/pages/create-coupon/controllers/create_coupon_controller.dart';

class ChooseProducts extends GetView<CreateCouponController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text(
          'Choose Products',
          style: TextStyle(color: Colors.black87),
        ),
        leading: Container(
          padding: const EdgeInsets.all(12),
          child: ClipOval(
            child: Material(
              color: Colors.grey.shade300,
              // Button color
              child: InkWell(
                splashColor: Colors.blueAccent, // Splash color
                onTap: () {
                  Get.back();
                  controller.clearChosen();
                },
                child: Icon(
                  Icons.chevron_left,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 25.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          )
        ]),
        child: Column(
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Tìm kiếm',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                ),
              ),
            ),
            Obx(() {
              final products = controller.products;
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    Product pro = products[index];
                    return ListTile(
                      leading: Image.network(pro.imageUrl!),
                      title: Text(pro.name!),
                      subtitle: Text(pro.description!.substring(0, 40) + '...'),
                      trailing: Checkbox(
                        onChanged: (value) => controller.choose(value, pro),
                        value: pro.isSelected,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    indent: 15,
                    endIndent: 15,
                    thickness: 1,
                    height: 15,
                    color: Colors.black45,
                  ),
                  itemCount: products.length,
                ),
              );
            }),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('XÁC NHẬN')),
          ],
        ),
      ),
    );
  }
}
