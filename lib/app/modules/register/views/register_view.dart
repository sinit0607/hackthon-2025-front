import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:particles_fly/particles_fly.dart';

import '../../../data/components/Helpers/validation_helper.dart';
import '../../../data/components/app_color.dart';
import '../../../data/components/app_icons_path.dart';
import '../../../data/components/config.dart';
import '../../../data/components/custom_text.dart';
import '../../../data/components/custome_button.dart';
import '../../../data/components/custome_textfeild.dart';
import '../../../data/components/get_size.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

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
            particleColor: AppColors.appWhite,
            lineColor: AppColors.appWhite,
          ),
          Center(
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
                        color: AppColors.appBlack,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80))),
                    height: H.h55(context),
                    width: W.w100(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: W.w4(context)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: H.h2(context),
                          ),
                          CommonTextField(
                            maxLength: 20,
                            focusNode: FocusNode(),
                            prefixIcon: SizedBox(
                              width: W.w10(context),
                              height: H.h5(context),
                              child: const Center(
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
                            focusNode: FocusNode(),
                            prefixIcon: SizedBox(
                              width: W.w10(context),
                              height: H.h5(context),
                              child: const Center(
                                child: Icon(
                                  Icons.email,
                                  color: AppColors.appWhite,
                                ),
                              ),
                            ),
                            hintText: "Email",
                            hintStyle: buildCommonStyle(),
                            controller: TextEditingController(),
                            validate: Validations.validateEmail,
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
                          CustomButton(
                              height: H.h6(context),
                              buttonTitle: const CommonText(
                                text: 'Sing Up',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              borderRadius: 20,
                              onPress: () {
                                Get.toNamed(Routes.DASHBOARD);
                              }),
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
                                Get.offAllNamed(Routes.LOGIN);
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
