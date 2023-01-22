import 'package:flutter/material.dart';
import 'package:online_course/model/post.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/feature_item.dart';

class SinglePostScreen extends StatefulWidget {
  const SinglePostScreen({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextEditingController _commentEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getAppBar(
                  widget.post,
                ),
                SizedBox(
                  height: 15,
                ),
                FeatureItem(
                  onTap: () {
                    print("hello ");
                  },
                  // post: feedController.widget.posts[index],
                  post: widget.post,
                ),
                SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // itemCount: comments.length,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  // Text(
                                  //   comments[index]["name"],
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  // Text(
                                  //   comments[index]["comment"],
                                  //   style: TextStyle(
                                  //     fontSize: 14,
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            // Text(
                            //   comments[index]["time"],
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     color: Colors.grey,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: buildCommentInputField(),
      ),
    );
  }

  Row buildCommentInputField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: TextFormField(
              controller: _commentEditingController,
              decoration: InputDecoration(
                hintText: "Write a comment...",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: primary,
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

Widget getAppBar(Post post) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 15.0,
      vertical: 10.0,
    ),
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.user?.name ?? "User Name",
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Please be mindful of your comment!",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
