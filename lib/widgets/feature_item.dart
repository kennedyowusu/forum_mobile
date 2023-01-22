import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/model/post.dart';
import 'package:online_course/screens/auth/post_details.dart';
import 'package:online_course/theme/color.dart';

import 'custom_image.dart';

class FeatureItem extends StatelessWidget {
  FeatureItem({
    Key? key,
    required this.post,
    this.width = 280,
    this.height = 290,
    this.onTap,
  }) : super(key: key);
  final Post post;
  final double width;
  final double height;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 15, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            // CustomImage(data["image"],
            //   width: double.infinity, height: 190,
            //   radius: 15,
            // ),
            // Positioned(
            //   top: 170, right: 15,
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: primary,
            //       borderRadius: BorderRadius.circular(20),
            //       boxShadow: [
            //         BoxShadow(
            //           color: shadowColor.withOpacity(0.05),
            //           spreadRadius: 1,
            //           blurRadius: 1,
            //           offset: Offset(0, 0),
            //         ),
            //       ],
            //     ),
            //     child: Text(data["price"],
            //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '${post.description}',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: textColor,
                  // overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              top: 210,
              child: Container(
                width: width - 20,
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${post.user?.name}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildFavoriteAndComment(),
                        // getAttribute(
                        //   Icons.play_circle_outlined,
                        //   labelColor,
                        //   data["session"],
                        // ),
                        // SizedBox(
                        //   width: 12,
                        // ),
                        // getAttribute(
                        //   Icons.schedule_rounded,
                        //   labelColor,
                        //   data["duration"],
                        // ),
                        // SizedBox(
                        //   width: 12,
                        // ),
                        // getAttribute(Icons.star, yellow, data["review"]),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildFavoriteAndComment() {
    return Row(
      children: [
        getAttribute(
          Icons.favorite_border,
          Colors.red,
          '100',
          onTap: () {},
        ),
        SizedBox(
          width: 15,
        ),
        getAttribute(
          Icons.comment,
          labelColor,
          "100",
          onTap: () {
            Get.to(
              () => SinglePostScreen(post: post),
            );
            print("Comment");
          },
        ),
      ],
    );
  }

  getAttribute(IconData icon, Color color, String info,
      {required Function()? onTap}) {
    return Row(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            size: 25,
            color: color,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            info,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: labelColor, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
