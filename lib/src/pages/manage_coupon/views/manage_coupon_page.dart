import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/pages/manage_coupon/controllers/manage_coupon_controller.dart';
import 'package:indoor_positioning_visitor/src/pages/manage_coupon/views/slidable_widget.dart';

class ManageCouponPage extends GetView<ManageCouponController> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'DANH SÁCH KHUYẾN MÃI',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Container(child: Obx(() {
        final coupons = controller.listCoupon;
        return _buildCoupons(coupons);
      })),
    );
  }
}

Widget _buildCoupons(List<Coupon> coupons) {
  return ListView.separated(
    itemCount: coupons.length,
    itemBuilder: (context, index) {
      final coupon = coupons[index];
      return SlidableWidget(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              coupon.imageUrl ?? '',
              height: 80,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  width: 240,
                  child: Text(coupon.name ?? '',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  width: 240,
                  child: Text(
                    coupon.description ?? '',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.info),
                  label: Text('Xem chi tiết'),
                ),
              ],
            ),
          ],
        ),
      );
    },
    separatorBuilder: (context, index) => Divider(
      indent: 30,
      endIndent: 30,
      color: Colors.black,
    ),
  );
}
