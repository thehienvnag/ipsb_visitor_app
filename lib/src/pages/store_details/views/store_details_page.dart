import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:indoor_positioning_visitor/src/models/product.dart';
import 'package:indoor_positioning_visitor/src/pages/store_details/controllers/store_details_controller.dart';

class StoreDetailsPage extends GetView<StoreDetailsController> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              child: Image.network(
                  'https://scontent-hkg4-2.xx.fbcdn.net/v/t1.18169-9/12143272_1641373789476730_6172127264499031070_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=ba80b0&_nc_ohc=Hsq3FRjDMpcAX-qh2Qz&_nc_ht=scontent-hkg4-2.xx&oh=1f40e631cc8bcdc0a15b127ae11e03fc&oe=60D3B08C'),
            ),
            Container(
              margin: EdgeInsets.only(right: 220, top: 10),
              child: Text(
                'HIGHLANDS COFFEE',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 90),
              child: Text('Thương Hiệu Cà Phê Tự Hào Sinh Ra Từ Đất Việt'),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Color(0xff0DB5B4),
                    ),
                  ),
                  Text('Tầng 1 - Vincom Lê Văn Việt'),
                ],
              ),
            ),
            // Divider(
            //   height: 10,
            //   thickness: 2,
            // ),
            Container(
              child: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Sản phẩm',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Vé ưu đãi',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildProducts(),
                  _buildCoupons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProducts() {
    return ListView.separated(
      itemBuilder: (context, index) {
        Product product = listProduct[index];
        return Row(
          children: [
            Image.network(
              product.imageUrl ?? '',
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 42, bottom: 5),
                      child: Text(product.name ?? '',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                    Container(
                      child: Text(
                        '${product.price} VNĐ',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 250,
                  child: Text(
                    product.description ?? '',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(
        indent: 30,
        endIndent: 30,
        color: Colors.black,
      ),
      itemCount: listProduct.length,
    );
  }

  Widget _buildCoupons() {
    return ListView.separated(
      itemCount: coupons.length,
      itemBuilder: (context, index) {
        final coupon = coupons[index];
        return Row(
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
        );
      },
      separatorBuilder: (context, index) => Divider(
        indent: 30,
        endIndent: 30,
        color: Colors.black,
      ),
    );
  }
}

List<Product> listProduct = [
  Product(
    id: 1,
    name: 'GOLDEN LOTUS TEA',
    description:
        'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
    price: 39000,
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Product(
    id: 1,
    name: 'GOLDEN LOTUS TEA',
    description:
        'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
    price: 39000,
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Product(
    id: 1,
    name: 'GOLDEN LOTUS TEA',
    description:
        'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
    price: 39000,
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Product(
    id: 1,
    name: 'GOLDEN LOTUS TEA',
    description:
        'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
    price: 39000,
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
];

final coupons = [
  Coupon(
    id: 1,
    name: 'THỬ PHINDI MỚI!',
    description:
        'Thêm 6.000/ly để đổi ly PhinDi tặng sang cỡ vừa hoặc 10.000/ly để đổi sang cỡ lớn',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Coupon(
    id: 2,
    name: 'CHỌN FREEZE TRÀ XANH, NHẬN THẺ TẬN HƯỞNG!',
    description:
        'Thưởng thức sự kết hợp hoàn hảo giữa vị Trà Xanh Đậm Đà cùng những miếng Thạch Giòn Khó Cưỡng.',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Coupon(
    id: 3,
    name: 'SỔ ƯU ĐÃI MỪNG 300 QUÁN',
    description:
        'Từ ngày 07/07/2019 đến ngày 21/07/2019 tại Highlands Coffee® toàn quốc.',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Coupon(
    id: 4,
    name: 'GIẢM 30K ĐƠN TỪ 100K',
    description:
        'E-Voucher giảm giá 30k cho đơn hàng 100k khi thanh toán bằng Airpay QR hoặc BLE Scan & Pay',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
];

class Coupon {
  final int? id;
  final String? name, description, imageUrl;
  Coupon({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
  });
}
