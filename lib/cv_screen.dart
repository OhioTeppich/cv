import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';

class CvScreen extends StatefulWidget {
  const CvScreen({super.key});

  @override
  State<CvScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {
  Offset position = Offset.zero;
  double radius = 0;
  bool showMouseContainer = false;
  int counter = 0;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(listener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.removeListener(listener);
    scrollController.dispose();
  }

  void listener() {
    if (scrollController.position.pixels >= 1000 && counter <= 500) {
      scrollController.jumpTo(1000);
      setState(() {
        counter += 1;
      });
      print(counter);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (scrollController.position.pixels >= 1000) {}

          return true;
        },
        child: ListView(
          controller: scrollController,
          children: [
            MouseRegion(
              onExit: (event) => setState(() {
                showMouseContainer = false;
              }),
              child: Listener(
                onPointerHover: (event) {
                  updateMouseContainerPosition(event, screenWidth);
                },
                onPointerSignal: (event) {
                  updateMouseContainerPosition(event, screenWidth);
                },
                child: Stack(
                  children: [
                    Container(
                      height: screenHeight,
                      width: screenWidth,
                      color: Colors.green,
                    ),
                    Center(
                      child: Container(
                        color: Colors.blue,
                        height: 300,
                        width: 600,
                        child: const Center(
                          child: Text('Christian Maciosek'),
                        ),
                      ),
                    ),
                    showMouseContainer
                        ? Positioned(
                            left: position.dx - 50,
                            top: position.dy - 50,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(radius),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Container(
              height: 500,
              color: Colors.purple,
            ),
            Container(
              height: 500,
              color: Colors.red,
            ),
            Container(
              height: 500,
              color: Colors.yellow,
            )
          ],
        ),
      ),
    );
  }

  void updateMouseContainerPosition(PointerEvent event, double screenWidth) {
    setState(() {
      showMouseContainer = true;
      position = event.localPosition;
      if (event.localPosition.dy >= 0 &&
          event.localPosition.dy <= 300 &&
          event.localPosition.dx >= screenWidth / 2 - 300 &&
          event.localPosition.dx <= screenWidth / 2 + 300) {
        radius = 50;
      } else {
        radius = 0;
      }
    });
  }
}
