import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/controller/comment.dart';
import 'package:online_course/helper/timeAgo.dart';
import 'package:online_course/model/post.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/widgets/comment_card.dart';

class SinglePostScreen extends StatefulWidget {
  const SinglePostScreen({Key? key, required this.post}) : super(key: key);

  final Feed post;

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController _commentCreationController = TextEditingController();
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
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            child: Column(
              children: [
                getAppBar(
                  widget.post,
                ),
                SizedBox(
                  height: 15,
                ),
                CommentCard(
                  feeds: widget.post,
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
                            itemCount: commentController.comments.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 10.0,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      '${commentController.comments[index].user.name}',
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
                                          '${timeAgo(commentController.comments[index].createdAt.toString())}',
                                          style: TextStyle(
                                            fontSize: 14,
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
                                    trailing: commentController
                                                .comments[index].user.id ==
                                            1
                                        ? IconButton(
                                            onPressed: () {
                                              commentController
                                                  .deleteComment(
                                                commentController
                                                    .comments[index].id,
                                              )
                                                  .then(
                                                (value) {
                                                  commentController
                                                      .fetchComments(
                                                    widget.post.id,
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                                        : null,
                                  ),
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
              controller: _commentCreationController,
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
            var response = await commentController.createComment(
              id: widget.post.id.toString(),
              comment: _commentCreationController.text.trim(),
            );
            if (response != null && response.statusCode == 201) {
              // commentController.fetchComments(widget.post.id);
            }

            // Clear the text field
            _commentCreationController.clear();
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

Widget getAppBar(Feed feeds) {
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
                  feeds.user.name[0].toUpperCase() +
                      feeds.user.name.substring(1),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
