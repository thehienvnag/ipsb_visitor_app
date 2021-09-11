import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

class ComboProductDetailPage extends StatefulWidget {
  @override
  _ComboProductDetailPageState createState() => _ComboProductDetailPageState();
}

class _ComboProductDetailPageState extends State<ComboProductDetailPage> {
  int activeIndex = 0;
  final urlImages = [
    'https://cdn.jamja.vn/blog/wp-content/uploads/2017/10/bo-san-pham-tea-tree-cua-the-body-shop-12.jpg',
    'https://cochiskin.com/wp-content/uploads/2018/05/Tinh-dầu-tràm-trà-The-Body-Shop-‪Tea-Tree-Oil‬.jpg',
    'https://vn-test-11.slatic.net/p/e68fd21ee57840c804edce76afceb957.jpg',
    'https://cdn.jamja.vn/blog/wp-content/uploads/2017/10/bo-san-pham-tea-tree-cua-the-body-shop-9.jpg'
  ];
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: ,
          centerTitle: true,
          title: Text(
            'COMBO',
            // style: TextStyle(color: Colors.black),
          ),
          backgroundColor: AppColors.primary,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.gradientColor,
                begin: const FractionalOffset(0.2, 0.0),
                end: const FractionalOffset(0.4, 0.0),
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
        floatingActionButton: AnimatedFloatingActionButton(
            //Fab list
            fabButtons: <Widget>[buildVisitStore(), buildAddShoppingList()],
            key: key,
            colorStartAnimation: AppColors.primary,
            colorEndAnimation: Colors.pinkAccent,
            animatedIconData: AnimatedIcons.menu_close //To principal button
            ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 410,
                  viewportFraction: 1,
                  //autoPlay: true,
                  //reverse: true,
                  autoPlayInterval: Duration(seconds: 2),
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];
                  return buildImage(urlImage, index);
                },
              ),
              const SizedBox(height: 10),
              buildIndicator(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    width: 220,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Tea Tree Oil - The Body Shop',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 23),
                    child: Text(
                      '270.000 VND',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 27, right: 9, left: 9),
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, right: 13, left: 13),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.primary,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Total 3 Items in combo',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 27, right: 13, left: 13),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 70,
                            width: 80,
                            child: Image.network(
                                'https://vn-test-11.slatic.net/p/e68fd21ee57840c804edce76afceb957.jpg'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                'Sữa rửa mặt The Body Shop 250ml',
                                style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                '269. 000 VND',
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 27, right: 13, left: 13),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 70,
                            width: 80,
                            child: Image.network(
                                'https://vn-test-11.slatic.net/p/e68fd21ee57840c804edce76afceb957.jpg'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                'Sữa rửa mặt The Body Shop 250ml',
                                style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                '269. 000 VND',
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 27, right: 13, left: 13),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 70,
                            width: 80,
                            child: Image.network(
                                'https://vn-test-11.slatic.net/p/e68fd21ee57840c804edce76afceb957.jpg'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                'Sữa rửa mặt The Body Shop 250ml',
                                style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                '269. 000 VND',
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 27, right: 9, left: 9),
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'DESCRIPTION:',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: 1),
                      ),
                    ),
                    Text(
                      'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
                      style: TextStyle(fontSize: 16, letterSpacing: 1),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Image.network(
                          'https://cdn.jamja.vn/blog/wp-content/uploads/2017/10/bo-san-pham-tea-tree-cua-the-body-shop-12.jpg'),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Sản phẩm của The Body Shop',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 1),
                      ),
                    ),
                    Text(
                      'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
                      style: TextStyle(fontSize: 16, letterSpacing: 1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      );
  Widget buildImage(String urlImage, int index) => Container(
        //margin: EdgeInsets.symmetric(horizontal: 24),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: JumpingDotEffect(
          dotWidth: 10,
          dotHeight: 10,
        ),
      );

  Widget buildVisitStore() => FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onPressed: () {},
        foregroundColor: Colors.white,
        backgroundColor: AppColors.secondary,
        icon: Icon(
          Icons.directions,
          color: Colors.white,
        ),
        label: Text('DIRECTIONS'),
      );
  Widget buildAddShoppingList() => FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onPressed: () {},
        foregroundColor: Colors.white,
        backgroundColor: AppColors.secondary,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text('ADD SHOPPING LIST'),
      );
}
