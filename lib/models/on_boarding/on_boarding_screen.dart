import 'package:flutter/material.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_app/networks/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

BoardingModel ({
  @required this.image,
  @required this.title,
  @required this.body,
});

}
class OnBoardingScreen extends StatefulWidget
{
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController();

  List<BoardingModel> boarding =
  [
    BoardingModel(
        image: 'https://yallacompare.com/blog/egy/wp-content/uploads/sites/4/2019/09/online-shopping.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'
    ),
    BoardingModel(
  image: 'https://insight-egypt.com/wp-content/uploads/2020/04/breathtaking-online-shopping-statistics-you-never-knew-625x300.png',
  title: 'On Board 2 Title',
  body: 'On Board 2 Body'
  ),
    BoardingModel(
  image: 'https://yallacompare.com/blog/egy/wp-content/uploads/sites/4/2019/09/online-shopping.png',
  title: 'On Board 3 Title',
  body: 'On Board 3 Body'
  ),
  ];

  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value) {
      if(value)
        {
          navigateAndFinish(
            context,
            ShopLoginScreen(),
          );
        }
    }
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[
          TextButton(
            onPressed: submit,
          child: Text(
          'SKIP',
          style: TextStyle(
            color: Colors.white
          ),
        ),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardcontroller,
                onPageChanged: (int index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState(()
                    {
                      isLast = true;
                    });
                      print('last');
                    } else
                      {
                        setState(()
                        {
                          isLast = false;
                        });
                      }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: boardcontroller,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,
                ),

                    count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    {
                      if(isLast)
                        {
                          submit();
                        }
                    }
                    boardcontroller.nextPage(duration: Duration(
                    milliseconds: 750,
                    ),
                        curve: Curves.decelerate,
                    );
                  },
                child: Icon(
                  Icons.arrow_forward_ios
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child:

      Image.network('https://yallacompare.com/blog/egy/wp-content/uploads/sites/4/2019/09/online-shopping.png')),
      Text(
        '${model.title} ',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
    ],
  );
}
