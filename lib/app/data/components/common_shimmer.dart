import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'app_color.dart';

class CommonShimmer {
  static containerShimmer() {
    return ListView.builder(
      scrollDirection: Axis.vertical,

      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.3),
          highlightColor: AppColors.appWhite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 70,
            ),
          ),
        );
      },
    );
  }

  static circularShimmer() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: AppColors.shimmerBase,
            highlightColor: AppColors.appWhite,
            child: Container(
                padding: EdgeInsets.only(left: index == 0 ? 16 : 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 60,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                )),
          );
        });
  }
}
