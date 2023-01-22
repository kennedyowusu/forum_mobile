import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/controller/comment.dart';
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

  TextEditingController _commentEditingController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commentController.fetchComments(widget.post.id);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                Obx(
                  () {
                    return commentController.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            // itemCount: comments.length,
                            itemCount: commentController.comments.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 10.0,
                                ),
                                child: Container(
                                  height: 100,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg",
                                      ),
                                    ),
                                    title: Text(
                                      '${commentController.comments[index].user!.name}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${commentController.comments[index].user!.createdAt}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${commentController.comments[index].body}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // show delete icon if the comment is made by the user
                                    // trailing: commentController
                                    //             .comments[index].userId ==
                                    //         1
                                    //     ? IconButton(
                                    //         onPressed: () {
                                    //           commentController
                                    //               .deleteComment(
                                    //                   commentController
                                    //                       .comments[index].id)
                                    //               .then((value) {
                                    //             commentController
                                    //                 .fetchComments(
                                    //                     widget.post.id);
                                    //           });
                                    //         },
                                    //         icon: Icon(
                                    //           Icons.delete,
                                    //           color: Colors.red,
                                    //         ),
                                    //       )
                                    //     : null,

                                    trailing: Text(
                                      "time",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  // child: Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Text(
                                  //             "Name",
                                  //             style: TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             "date",
                                  //             style: TextStyle(
                                  //               fontSize: 16,
                                  //               color: Colors.grey,
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: 5,
                                  //           ),
                                  //           Text(
                                  //             "comment",
                                  //             style: TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.w500,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     // Text(
                                  //     //   comments[index]["time"],
                                  //     //   style: TextStyle(
                                  //     //     fontSize: 14,
                                  //     //     color: Colors.grey,
                                  //     //   ),
                                  //     // ),
                                  //   ],
                                  // ),
                                ),
                              );
                            },
                          );
                  },
                )
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
        GestureDetector(
          onTap: () async {
            await commentController
                .createComment(
              id: widget.post.id,
              comment: _commentEditingController.text.trim(),
            )
                .then((value) {
              commentController.fetchComments(widget.post.id);
            });
            _commentEditingController.clear();
          },
          child: Container(
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
