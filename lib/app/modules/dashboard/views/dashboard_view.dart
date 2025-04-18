import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:codesapp/app/data/components/app_color.dart';
import 'package:codesapp/app/data/components/app_icons_path.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);

  DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBlack,
      body: GetBuilder(
        builder: (DashboardController dashboardController) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.appWhite,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: SidebarX(
                    controller: dashboardController.sidebarXController,
                    theme: SidebarXTheme(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.appBlack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(color: Colors.white),
                      selectedTextStyle: const TextStyle(color: Colors.white),
                      itemTextPadding: const EdgeInsets.only(left: 30),
                      selectedItemTextPadding: const EdgeInsets.only(left: 30),
                      selectedItemDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.appBlack.withOpacity(0.37),
                        ),
                        gradient: const LinearGradient(
                          colors: [AppColors.appBlack, AppColors.appColor],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.28),
                            blurRadius: 30,
                          )
                        ],
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    extendedTheme: const SidebarXTheme(
                      width: 200,
                      decoration: BoxDecoration(
                        color: AppColors.appBlack,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                    footerDivider: divider,
                    headerBuilder: (context, extended) {
                      return SizedBox(
                        height: 100,
                        child: Image.asset(AppIcons.appIcon),
                      );
                    },
                    items: [
                      SidebarXItem(
                        onTap: () {
                          dashboardController.count = 0;
                        },
                        icon: Icons.home,
                        label: 'Home',
                      ),
                      SidebarXItem(
                        onTap: () {
                          dashboardController.count = 1;
                        },
                        icon: Icons.search,
                        label: 'Search',
                      ),
                      SidebarXItem(
                        icon: Icons.notifications,
                        onTap: () {
                          dashboardController.count = 2;
                        },
                        label: 'Notifications',
                      ),
                      SidebarXItem(
                        onTap: () {
                          dashboardController.count =3;
                        },
                        icon: Icons.person,
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: dashboardController
                      .screenList[dashboardController.count],
                ),
              )
            ],
          );
        }
      ),
    );
  }

  final divider = Divider(color: AppColors.white20.withOpacity(0.3), height: 1);
}
