import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:particles_fly/particles_fly.dart';
import 'package:codesapp/app/data/components/app_color.dart';
import 'package:codesapp/app/data/components/app_icons_path.dart';
import 'package:codesapp/app/data/components/custom_text.dart';
import 'package:codesapp/app/data/components/custome_button.dart';
import 'package:codesapp/app/routes/app_pages.dart';

import '../../../data/components/get_size.dart';
import '../controllers/on_boarding_controller.dart';
import 'Codezapp_Features.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Stack(
        children: [
          ParticlesFly(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            connectDots: true,
            isRandomColor: false,
            numberOfParticles: 30,
            particleColor: AppColors.appWhite.withOpacity(0.5),
            lineColor: AppColors.appWhite.withOpacity(0.5),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: W.w4(context)),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: H.h10(context),
                          ),
                          Image.asset(
                            AppIcons.appIconWithOutBg,
                            scale: 2,
                          ),
                          CommonText(
                            text: "CodesApp",
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: H.h4(context),
                          ),
                          const CommonText(
                            text: "Watch. Learn. Code Better.",
                            maxLines: 2,
                            fontSize: 16,
                          ),
                          SizedBox(
                            height: H.h2(context),
                          ),
                          const CommonText(
                            text:
                                "From Python to Java, Web Dev to AI everything you need is here.",
                            maxLines: 2,
                            fontSize: 16,
                          ),
                          const CommonText(
                            text: "all in one place.",
                            maxLines: 2,
                            fontSize: 16,
                          ),
                          SizedBox(
                            height: H.h8(context),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                    height: H.h6(context),
                                    buttonTitle: const CommonText(
                                      text: 'Sign up for Free',
                                      fontSize: 18,
                                    ),
                                    borderRadius: 20,
                                    onPress: () {
                                      Get.offAllNamed(Routes.LOGIN);
                                    }),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CustomButton(
                                    height: H.h6(context),
                                    buttonTitle: const CommonText(
                                      text: 'Premium',
                                      fontSize: 18,
                                    ),
                                    borderRadius: 20,
                                    onPress: () {
                                      showPremiumFeatureDialog(context);
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: H.h2(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CodezappFeatures(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showPremiumFeatureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.code,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                "Advanced Coding + Live Learning",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Unlock premium access to real-time expert-led sessions, advanced code walkthroughs, and personal mentorship.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Get.offAllNamed(Routes.REGISTER);
                  // Navigate to premium page or perform action
                },
                child: Text("Explore Premium"),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Maybe Later",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
