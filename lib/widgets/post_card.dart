import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/controller/favorite_and_unfavorite.dart';
import 'package:online_course/controller/post.dart';
import 'package:online_course/controller/user.dart';
import 'package:online_course/model/post.dart';
import 'package:online_course/screens/auth/post_details.dart';
import 'package:online_course/theme/color.dart';

class PostCard extends StatefulWidget {
  PostCard({
    Key? key,
    required this.feeds,
    this.width = 280,
    this.height = 290,
    this.onTap,
  }) : super(key: key);
  final Feed feeds;
  final double width;
  final double height;
  final GestureTapCallback? onTap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final FavoriteAndUnfavoritePostController
      favoriteAndUnfavoritePostController =
      Get.put(FavoriteAndUnfavoritePostController());

  final PostController postController = Get.put(PostController());
  final UserController userController = Get.put(UserController());

  bool likedPost = false;
  Color likeColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => SinglePostScreen(post: widget.feeds),
        );
      },
      child: Container(
        width: widget.width,
        height: widget.height - 40,
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
                width: widget.width + 60,
                height: widget.height - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // image: DecorationImage(
                  //   image: NetworkImage('${widget.feeds.image}'),
                  //   fit: BoxFit.cover,
                  // ),
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
                      fontSize: 15.5,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: Container(
                width: widget.width - 20,
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
                        buildFavoriteAndComment(),
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
          Icons.favorite_sharp,
          widget.feeds.liked == true ? Colors.red : likeColor,
          likedPost ? '0' : widget.feeds.likesCount.toString(),
          onTap: () async {
            await favoriteAndUnfavoritePostController
                .favoriteAndUnfavoritePost(widget.feeds.id);

            postController.fetchPosts();
          },
        ),
        SizedBox(
          width: 15,
        ),
        getAttribute(
          Icons.comment,
          labelColor,
          '0',
          onTap: () {
            Get.to(
              () => SinglePostScreen(post: widget.feeds),
            );
          },
        ),
        SizedBox(
          width: 15,
        ),
        getAttribute(
          Icons.delete_sharp,
          labelColor,
          '',
          onTap: () {
            postController.deletePost(id: widget.feeds.id);
            // postController.fetchPosts();
            print('delete post with id ${widget.feeds.id}');
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
            size: 30,
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
            style: TextStyle(
              color: labelColor,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
