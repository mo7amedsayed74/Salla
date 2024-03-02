import 'package:flutter/material.dart';
import 'package:shop_app/Screens/login_screen.dart';
import 'package:shop_app/networks/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components.dart';
import '../constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  
  final PageController boardController = PageController();

  final List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      image: 'assets/images/00.jpg',
      title: 'Title Screen_1',
      subTitle: 'hashhhh...',
    ),
    OnBoardingModel(
      image: 'assets/images/00.jpg',
      title: 'Title Screen_2',
      subTitle: 'hashhhh...',
    ),
    OnBoardingModel(
      image: 'assets/images/00.jpg',
      title: 'Title Screen_3',
      subTitle: 'hashhhh...',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          TextButton(
            child: const Text(
              'SKiP',
              style: TextStyle(
                color: defaultColor,
              ),
            ),
            onPressed: (){ goToLoginScreen(); },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                //physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index){
                  setState(() {
                    (index == onBoardingList.length-1)? isLast = true: isLast = false;
                  });
                },
                itemBuilder: (context, index) => buildBoardingScreen(onBoardingList[index]),
                itemCount: onBoardingList.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: onBoardingList.length,
                  effect: WormEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey[400]!,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if(isLast){
                      goToLoginScreen();
                    }else{
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ************************

  Widget buildBoardingScreen(OnBoardingModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(item.image),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          item.subTitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
  
  void goToLoginScreen(){
    CacheHelper.saveData(key: 'showOnBoardingScreen', value: false).then((value) {
      context.navigatePushReplacement( // using extension
          screenToView: LoginScreen()
      );
    });
  }
  
}

class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}
