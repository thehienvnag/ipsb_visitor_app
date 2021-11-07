import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/notifications/controllers/notifications_controller.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_bottom_bar.dart';
import 'package:ipsb_visitor_app/src/models/notification.dart';
import 'package:ipsb_visitor_app/src/widgets/user_welcome.dart';

class NotificationsPage extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 5),
            child: ProfileIcon(),
          )
        ],
      ),
      bottomNavigationBar: CustomBottombar(),
      body: Container(
        // padding: const EdgeInsets.all(30),
        child: listNotification(),
      ),
    );
  }

  Widget listNotification() {
    return Obx(() {
      if (AuthServices.userLoggedIn.value.id == null) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, right: 20),
                height: 200,
                width: 200,
                child: Image.asset(
                    ConstImg.empty),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  'Notification is not available',
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
                  'Come back to check after login in your account',
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
        );
      }
      final list = controller.notifications;
      if (controller.loading.value) {
        return Center(child: CircularProgressIndicator());
        // );
      }
      if (list.isEmpty) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, right: 20),
                height: 200,
                width: 200,
                child: Image.asset(
                    ConstImg.empty),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  'Notification is empty',
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
                  'Come back to check after receiving new notification',
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
        );
      }
      return ListView.builder(
        itemBuilder: (context, index) {
          // return ListView.builder(
          //   shrinkWrap: true,
          //   itemBuilder: (context, index) =>
          return notificationItem(list[index], context);
          // itemCount: list.length,
          // );
        },
        itemCount: list.length,
      );
    });
  }

  Widget notificationItem(Notifications element, BuildContext context) {
    List<String> parameter = [];
    if (element.parameter != null) {
      parameter = element.parameter!.split(":");
    }
    return GestureDetector(
      onTap: () => {
        controller.updateNotifications(element.id!, Constants.read),
        Get.toNamed(
          element.screen!,
          parameters: {
            parameter.first: parameter.last,
          },
        )
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            Container(
              height: context.height * 0.105,
              width: context.height * 0.105,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    // 'https://raw.githubusercontent.com/thehienvnag/beauty-at-home-mobile/main/public/img/notification.PNG'),
                    // 'https://ibb.co/DfHrstZ'
                    element.imageUrl != null
                        ? element.imageUrl!
                        : 'https://ibb.co/DfHrstZ',
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              width: context.width * 0.69,
              height: context.height * 0.18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    element.title!,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(element.body!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Utils.parseDateTimeToDate(element.date!),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      element.status == 'Unread'
                          ? Image.asset(
                              ConstImg.newNotification,
                              width: context.height * 0.08,
                              height: context.height * 0.08,
                            )
                          : SizedBox(),
                    ],
                  )
                ],
              ),
            ),

            // ],
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
