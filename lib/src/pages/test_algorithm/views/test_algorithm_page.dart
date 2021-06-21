import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/controllers/test_algorithm_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/ticket_box.dart';

class TestAlgorithmPage extends GetView<TestAlgorithmController> {
  @override
  Widget build(BuildContext context) {
    return testAlgorithm();
  }

  Scaffold testAlgorithm() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => controller.getEdges(),
              child: Text('Get edges'),
            ),
            TicketBox(
              child: Text('Hello'),
              fromEdgeMain: 74,
              fromEdgeSeparator: 140,
              isOvalSeparator: false,
              smallClipRadius: 15,
              clipRadius: 22,
              numberOfSmallClips: 8,
              ticketWidth: 340,
            ),
          ],
        ),
      ),
    );
  }
}
