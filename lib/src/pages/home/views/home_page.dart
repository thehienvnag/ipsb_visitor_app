import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: '),
              TextField(
                onSubmitted: (value) => controller.inputData('name', value),
              ),
              OutlinedButton.icon(
                onPressed: () => controller.createCategory(),
                icon: Icon(Icons.post_add),
                label: Text('Post category'),
              ),
              OutlinedButton.icon(
                onPressed: () => controller.pickImage(),
                icon: Icon(Icons.camera_alt),
                label: Text('Pick image'),
              ),
              OutlinedButton.icon(
                onPressed: () => controller.getProductCategories(),
                icon: Icon(Icons.category),
                label: Text('Get product categories'),
              ),
              Obx(() {
                String image = controller.image.value;
                if (image.isEmpty) {
                  return Text('No file has been picked!');
                }
                return Column(
                  children: [
                    Image.file(
                      File(image),
                      width: 200,
                    ),
                    OutlinedButton.icon(
                      onPressed: () => controller.uploadImage(),
                      icon: Icon(Icons.upload),
                      label: Text('UPLOAD'),
                    ),
                  ],
                );
              }),
              Center(
                child: Obx(() {
                  var listPC = controller.productCategories;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: listPC.length,
                    itemBuilder: (context, index) =>
                        Text(listPC[index].toString()),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var list = [].map((e) => null).toList();
}
