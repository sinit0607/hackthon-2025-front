import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:codesapp/app/data/components/app_color.dart';
import 'package:codesapp/app/data/components/app_icons_path.dart';
import 'package:codesapp/app/data/components/custom_text.dart';

import '../../../data/components/Custom_shape.dart';
import '../../../data/components/get_size.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBlack,
      appBar: AppBar(
        backgroundColor: AppColors.appBlack,
        title: const CommonText(
          text: 'codesapp',
          fontSize: 18,
        ),
        leading: Image.asset(
          AppIcons.appIcon,
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            AppIcons.messageIcon,
            color: AppColors.appWhite,
            scale: 20,
          ),
          SizedBox(
            width: W.w4(context),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: H.h2(context),
          ),
          CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int itemIndex,
                    int pageViewIndex) =>
                SuperellipseCard(
                    radius: 90,
                    child: CategoryTile(
                        imageUrl:
                            "https://images.unsplash.com/photo-1713458101343-ae063854e754?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")),
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 0.85,
              height: H.h57(context),
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: H.h2(context),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: W.w100(context),
                height: H.h12(context),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.appWhite.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.1)),
                child: Center(
                  child: ListTile(
                    leading: Container(
                      height: H.h20(context),
                      width: W.w20(context),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: Image.network(
                              "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2960&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            ).image,
                            fit: BoxFit.cover,
                          )),
                    ),
                    title: const CommonText(
                      text: "Sinit Nakrani",
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    subtitle: CommonText(
                      text:
                          "Nature photography is a genre of photography focused on elements of the outdoors.",
                      maxLines: 3,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                      fontSize: 14,
                      color: AppColors.appWhite.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
