import 'package:cv/core/cv_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CvScreen extends StatefulWidget {
  const CvScreen({super.key});

  @override
  State<CvScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {
  Offset position = Offset.zero;
  bool showMouseContainer = false;
  int counter = 0;
  BoxDecoration boxDecoration = BoxDecoration(
    border: Border.all(),
    borderRadius: BorderRadius.circular(0),
  );

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scrollController.addListener(listener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // scrollController.removeListener(listener);
    scrollController.dispose();
  }

  // void listener() {
  //   if (scrollController.position.pixels >= 1000 && counter <= 500) {
  //     scrollController.jumpTo(1000);
  //     setState(() {
  //       counter += 1;
  //     });
  //     print(counter);
  //   }
  // }

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
                  updateMouseContainerPosition(
                    event,
                    screenWidth,
                    screenHeight,
                  );
                },
                onPointerSignal: (event) {
                  updateMouseContainerPosition(
                    event,
                    screenWidth,
                    screenHeight,
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: screenHeight / 2,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            CvTheme.primaryColor,
                            CvTheme.brightColor,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 72.0,
                      width: 72.0,
                      child: GestureDetector(
                        onTap: () =>
                            _launchUrl('https://github.com/OhioTeppich'),
                        child: SvgPicture.network(
                          'https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg',
                          width: 72.0,
                          height: 72.0,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 72.0,
                      child: SizedBox(
                        height: 72.0,
                        width: 72.0,
                        child: GestureDetector(
                          onTap: () => _launchUrl(
                              'https://www.linkedin.com/in/christian-maciosek-4921aa249/'),
                          child: SvgPicture.network(
                            'https://upload.wikimedia.org/wikipedia/commons/8/81/LinkedIn_icon.svg',
                            height: 72.0,
                            width: 72.0,
                          ),
                        ),
                      ),
                    ),
                    showMouseContainer
                        ? Positioned(
                            left: position.dx - 37.5,
                            top: position.dy - 37.5,
                            child: IgnorePointer(
                              child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: boxDecoration),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Container(
              height: 500,
              color: CvTheme.primaryColor,
              child: Row(
                children: [
                  Text(
                    'Christian ',
                    style: CvTheme.h3,
                  ),
                  Text(
                    'Maciosek',
                    style: CvTheme.h1,
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              color: CvTheme.primaryColor,
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Daily Use',
                        style: CvTheme.h2,
                      ),
                      SvgPicture.asset('assets/images/flutter.svg'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Used',
                        style: CvTheme.h2,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateMouseContainerPosition(
    PointerEvent event,
    double screenWidth,
    double screenHeight,
  ) {
    setState(() {
      showMouseContainer = true;
      position = event.localPosition;
      if (event.localPosition.dy >= (screenHeight / 2) - 72.0 &&
          event.localPosition.dy <= (screenHeight / 2) &&
          event.localPosition.dx >= screenWidth - 144.0 &&
          event.localPosition.dx <= screenWidth) {
        boxDecoration = BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(50),
            color: CvTheme.tertiaryColor.withOpacity(0.6));
      } else {
        boxDecoration = BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(0),
        );
      }
    });
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri);
  }
}
