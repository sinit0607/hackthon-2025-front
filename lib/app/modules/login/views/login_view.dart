import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:particles_fly/particles_fly.dart';
import 'package:codesapp/app/data/components/app_color.dart';
import 'package:codesapp/app/data/components/app_icons_path.dart';
import 'package:codesapp/app/data/components/custom_text.dart';
import 'package:codesapp/app/routes/app_pages.dart';

import '../../../data/components/Helpers/validation_helper.dart';
import '../../../data/components/config.dart';
import '../../../data/components/custome_button.dart';
import '../../../data/components/custome_textfeild.dart';
import '../../../data/components/get_size.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

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
            numberOfParticles: 20,
            particleColor: AppColors.appWhite,
            lineColor: AppColors.appWhite,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: W.w6(context)),
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    children: [
                      SizedBox(
                        height: H.h8(context),
                      ),
                      Image.asset(
                        AppIcons.appIconWithOutBg,
                        scale: 4,
                      ),
                      const CommonText(
                          textAlign: TextAlign.end,
                          text: "codesapp",
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: H.h6(context),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.appWhite),
                            color: AppColors.appColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(80),
                                bottomRight: Radius.circular(80))),
                        height: H.h55(context),
                        width: W.w100(context),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: W.w4(context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: H.h2(context),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: const CommonText(
                                  text: "Welcome Back!",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: H.h2(context),
                              ),
                              CommonTextField(
                                maxLength: 10,
                                focusNode: FocusNode(),
                                prefixIcon: SizedBox(
                                  width: W.w10(context),
                                  height: H.h5(context),
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.appWhite,
                                    ),
                                  ),
                                ),
                                hintText: "User name",
                                hintStyle: buildCommonStyle(),
                                controller: TextEditingController(),
                                validate: Validations.validateMobilenumber,
                                input: TextInputType.number,
                              ),
                              SizedBox(
                                height: H.h2(context),
                              ),
                              CommonTextField(
                                maxLength: 10,
                                focusNode: FocusNode(),
                                prefixIcon: SizedBox(
                                  width: W.w10(context),
                                  height: H.h5(context),
                                  child: const Center(
                                    child: Icon(
                                      Icons.key,
                                      color: AppColors.appWhite,
                                    ),
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: buildCommonStyle(),
                                controller: TextEditingController(),
                                validate: Validations.validatePassword,
                                input: TextInputType.number,
                                obscureText: true,
                                suffixVisibility: true,
                              ),
                              SizedBox(
                                height: H.h2(context),
                              ),
                              const CommonText(
                                  textAlign: TextAlign.end,
                                  text: "Forgot Password?",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              SizedBox(
                                height: H.h2(context),
                              ),
                              CustomButton(
                                  height: H.h6(context),
                                  buttonTitle: const CommonText(
                                    text: 'Login',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  borderRadius: 20,
                                  onPress: () {
                                    Get.offAllNamed(Routes.DASHBOARD);
                                  }),
                              SizedBox(
                                height: H.h2(context),
                              ),
                              CustomButton(
                                  height: H.h6(context),
                                  buttonTitle: const CommonText(
                                    text: 'Sign Up.',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  borderRadius: 20,
                                  onPress: () {
                                    Get.offAllNamed(Routes.REGISTER);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
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
