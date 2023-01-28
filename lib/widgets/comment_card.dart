import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/controller/favorite_and_unfavorite.dart';
import 'package:online_course/controller/post.dart';
import 'package:online_course/controller/user.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/model/post.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    Key? key,
    required this.feeds,
  }) : super(key: key);

  final Feed feeds;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  final FavoriteAndUnfavoritePostController
      favoriteAndUnfavoritePostController =
      Get.put(FavoriteAndUnfavoritePostController());

  final PostController postController = Get.put(PostController());
  final UserController userController = Get.put(UserController());

  bool likedPost = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Container(
          width: double.infinity,
          height: 230,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 15),
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${widget.feeds.title}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                child: Container(
                  width: width + 60,
                  height: height - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.0,
                      horizontal: 8.0,
                    ),
                    child: Text(
                      '${widget.feeds.description}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 140,
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.feeds.user.name}",
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
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await favoriteAndUnfavoritePostController
                                      .favoriteAndUnfavoritePost(
                                    widget.feeds.id,
                                  );

                                  postController.fetchPosts();
                                },
                                icon: Icon(
                                  Icons.favorite_sharp,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                '${widget.feeds.likesCount}',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete_sharp,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
