import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_shop/utils/colors.dart';
import 'package:food_shop/widgets/big_text.dart';
import 'package:food_shop/widgets/icon_and_text_widget.dart';
import 'package:food_shop/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final _height = 220.h;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 320.h,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
            size: Size.square(9.r),
            activeSize: Size(18.w, 9.h),
            activeColor: AppColors.mainColor,
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r)),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix4 = Matrix4.identity();

    var currentScale = ((index == _currentPageValue.floor()) ||
            (index == _currentPageValue.floor() - 1))
        ? (1 - (_currentPageValue - index) * (1 - _scaleFactor))
        : (index == _currentPageValue.floor() + 1)
            ? (_scaleFactor +
                (_currentPageValue - index + 1) * (1 - _scaleFactor))
            : _scaleFactor;

    var currentTrans = _height * (1 - currentScale) / 2;
    matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
      ..setTranslationRaw(0, currentTrans, 0);

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          Container(
            height: 220.h,
            margin: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: index.isEven ? Colors.blue : Colors.amber,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/food5.jpg'))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120.h,
              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFe8e8e8),
                    blurRadius: 5.h,
                    offset: Offset(0, 5.h),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5.w, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5.w, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Chinese Side',
                      size: 20.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: AppColors.mainColor,
                                    size: 15.h,
                                  )),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SmallText(
                          text: '4.5',
                          size: 15.sp,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        SmallText(
                          text: '1287',
                          size: 15.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SmallText(
                          text: 'comments',
                          size: 15.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: 'Normal',
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            icon: Icons.location_on,
                            text: '1.7km',
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: '32min',
                            iconColor: AppColors.iconColor2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
