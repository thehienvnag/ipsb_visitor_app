import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/pages/map/views/shopping_list_dialog.dart';

class ShoppingPoint extends StatelessWidget {
  static const double radius = 40;
  final String? index;
  final Store store;

  const ShoppingPoint({
    Key? key,
    this.index,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-24, -52),
      child: AvatarGlow(
        glowColor: Colors.grey.withOpacity(.1),
        endRadius: radius,
        duration: Duration(milliseconds: 1500),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 50),
        child: Material(
          color: Colors.transparent,
          // Replace this child with your own
          // elevation: 8.0,
          shape: CircleBorder(
            side: BorderSide(width: 0, color: Colors.white),
          ),
          child: GestureDetector(
            onTap: () {
              Get.bottomSheet(
                ShoppingListDialog(
                  store: store,
                ),
                enableDrag: false,
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Icon(
                    Icons.place_rounded,
                    size: 55,
                    color:
                        store.complete ? Colors.greenAccent : Colors.redAccent,
                  ),
                  Positioned(
                    top: 14,
                    left: 15,
                    child: Container(
                      width: 25,
                      height: 22,
                      color: store.complete
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      child: Center(
                        child: Text(
                          index ?? "0",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
