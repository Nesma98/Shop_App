import 'package:flutter/material.dart';
import 'package:onboarding_project/components/nav.dart';
import 'package:onboarding_project/layout/HomeScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Model {
  String image;
  String title;
  String body;
  Model({required this.body, required this.image, required this.title});
}

class onBoardingScreen extends StatefulWidget {
  onBoardingScreen({Key? key}) : super(key: key);

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<Model> DataModel = [
    Model(
        body: 'OnBoarding Body 1',
        image: 'assets/images.png',
        title: 'OnBoarding Title 1'),
    Model(
        body: 'OnBoarding Body 2',
        image: 'assets/images.png',
        title: 'OnBoarding Title 2'),
    Model(
        body: 'OnBoarding Body 3',
        image: 'assets/images.png',
        title: 'OnBoarding Title 3'),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    var boardController = PageController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                NavPushReplacement(context, HomeScreen());
              },
              child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (value) {
                  if (value == DataModel.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemCount: DataModel.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    OnBoardingWidget(model: DataModel[index]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                        activeDotColor: Colors.blue.shade800,
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5),
                    controller: boardController,
                    count: DataModel.length),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                     NavPushReplacement(context, HomeScreen());
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OnBoardingWidget extends StatelessWidget {
  OnBoardingWidget({Key? key, required this.model}) : super(key: key);

  Model model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            model.title,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            model.body,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
