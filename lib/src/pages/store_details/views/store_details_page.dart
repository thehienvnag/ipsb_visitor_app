import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';

import 'package:ipsb_visitor_app/src/pages/store_details/controllers/store_details_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';
import 'package:ipsb_visitor_app/src/widgets/rounded_button.dart';
import 'package:ipsb_visitor_app/src/widgets/animate_wrapper.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:readmore/readmore.dart';

class StoreDetailsPage extends GetView<StoreDetailsController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          controller: ScrollController(),
          physics: ClampingScrollPhysics(),
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  width: size.width,
                  child: Obx(() {
                    var store = controller.store.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                image: Utils.resolveDecoImg(store.imageUrl),
                                boxShadow: [AppBoxShadow.boxShadow],
                              ),
                            ),
                            Positioned(
                              top: 18,
                              left: 15,
                              child: RoundedButton(
                                icon: Icon(
                                  Icons.chevron_left,
                                  size: 40,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                                radius: 40,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 14, top: 20),
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            Formatter.shorten(store.name),
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 26),
                          ),
                        ),
                        ListTile(
                          subtitle: ReadMoreText(
                            store.description ?? "",
                            trimLines: 2,
                            style: TextStyle(color: Colors.black),
                            colorClickableText: Colors.blueAccent,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                          ),
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      color: Color(0xff0DB5B4),
                                    ),
                                  ),
                                  Text(store.formattedLocation()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              SliverToBoxAdapter(
                child: TabBar(
                  controller: controller.tabController,
                  indicatorColor: Colors.green,
                  tabs: [
                    Container(
                      width: 100,
                      child: Tab(
                        text: "PRODUCTS",
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Tab(
                        text: "COUPONS",
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Tab(
                        text: "FEEDBACKS",
                      ),
                    ),
                  ],
                  labelColor: Colors.black,
                  indicator: MaterialIndicator(
                    height: 5,
                    topLeftRadius: 8,
                    topRightRadius: 8,
                    horizontalPadding: 50,
                    tabPosition: TabPosition.bottom,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: controller.tabController,
            children: [
              _buildProducts(context),
              _buildCoupons(context),
              _buildFeedbacks(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty(String description, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Image.asset(
            ConstImg.empty,
            height: 60,
            width: 80,
          ),
          SizedBox(height: 10),
          Text(description),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildProducts(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Obx(() {
        final products = controller.listProduct;
        if (controller.loading.isTrue) {
          return _buildLoading();
        }
        if (products.isEmpty)
          return _buildEmpty("Store has no products!", context);
        return AnimationLimiter(
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 4 / 6,
            crossAxisCount: 2,
            children: List.generate(
              products.length,
              (int index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () => controller.gotoProductDetails(product.id),
                  child: AnimateWrapper(
                    index: index,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                      child: Card(
                        child: Container(
                          width: 200,
                          // padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      product.imageUrl ?? '',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  Formatter.shorten(product.name, 10),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  Formatter.price(product.price),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCoupons(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Obx(() {
        final coupons = controller.listCoupon;
        if (controller.loading.isTrue) {
          return _buildLoading();
        }
        if (coupons.isEmpty)
          return _buildEmpty("Store has no coupons!", context);
        return ListView.builder(
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            final coupon = coupons[index];
            return GestureDetector(
              onTap: () => controller.gotoCouponDetail(coupon),
              child: AnimateWrapper(
                index: index,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Color(0xffF5F5F7),
                    child: ListTile(
                      leading: Image.network(
                        coupon.imageUrl ?? '',
                        width: 50,
                      ),
                      title: Text(Formatter.shorten(coupon.name)),
                      subtitle: Text(Formatter.shorten(coupon.description)),
                      // trailing: TextButton.icon(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.local_activity),
                      //   label: Text('View Detail'),
                      // ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildFeedbacks(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Obx(() {
        final feedbacks = controller.listFeedbacked;
        if (controller.loading.isTrue) {
          return _buildLoading();
        }
        if (feedbacks.isEmpty)
          return _buildEmpty("Store has no feedbacks!", context);
        var store = controller.store.value;
        return ListView.builder(
          itemCount: feedbacks.length,
          itemBuilder: (context, index) {
            final feedback = feedbacks[index];
            return AnimateWrapper(
              index: index,
              child: Container(
                padding: const EdgeInsets.all(6),
                child: Card(
                  color: Color(0xffF5F5F7),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: CommentTreeWidget<Comment, Comment>(
                      Comment(
                          avatar: 'null', userName: 'null', content: 'null'),
                      [
                        Comment(
                            avatar: 'null', userName: 'null', content: 'null'),
                      ],
                      treeThemeData: TreeThemeData(
                          lineColor: Colors.grey.shade400, lineWidth: 3),
                      avatarRoot: (context, data) => PreferredSize(
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              NetworkImage(feedback.visitor!.imageUrl!),
                        ),
                        preferredSize: Size.fromRadius(18),
                      ),
                      avatarChild: (context, data) => PreferredSize(
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              NetworkImage(store.imageUrl.toString()),
                        ),
                        preferredSize: Size.fromRadius(12),
                      ),
                      contentChild: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.72,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    store.name.toString() + ' store',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ReadMoreText(
                                    feedback.feedbackReply ?? 'Not Reply',
                                    trimLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    colorClickableText: Colors.blueAccent,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      contentRoot: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        feedback.visitor!.name!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        Formatter.dateCaculator(
                                            feedback.feedbackDate),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  RatingBar.builder(
                                    initialRating: feedback.rateScore ?? 0,
                                    itemSize: 18,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, _) =>
                                        Icon(Icons.star, color: Colors.amber),
                                    onRatingUpdate: (value) => true,
                                    updateOnDrag: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ReadMoreText(
                                    feedback.feedbackContent ?? 'Not content',
                                    trimLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    colorClickableText: Colors.blueAccent,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                  ),
                                  if (feedback.feedbackImage != null)
                                    Container(
                                      width: size.width * 0.4,
                                      height: size.height * 0.12,
                                      alignment: Alignment.centerLeft,
                                      child: Card(
                                        child: Image(
                                          image: CachedNetworkImageProvider(
                                            feedback.feedbackImage!,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
