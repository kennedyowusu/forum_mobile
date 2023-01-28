import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_course/controller/post.dart';
import 'package:online_course/controller/user.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/feature_item.dart';
import 'package:online_course/widgets/notification_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final localStorage = GetStorage().read('token');

  final PostController feedController = Get.put(PostController());

  TextEditingController _postController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(userController.user.value.email);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getAppBar(),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.07,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Enter Title",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.1,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _postController,
                                decoration: InputDecoration(
                                  hintText: "What do you have in mind?",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await feedController.createPost(
                                  title: _titleController.text.trim(),
                                  description: _postController.text.trim(),
                                );
                                _titleController.clear();
                                _postController.clear();

                                feedController.fetchPosts();
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Obx(
                                    () {
                                      return feedController.isLoading.value
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.send,
                                              color: Colors.white,
                                            );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // getFeature(),

                Obx(
                  () => feedController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primary,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: feedController.feeds.length,
                          itemBuilder: (context, index) {
                            {
                              return FeatureItem(
                                onTap: () {
                                },
                                feeds: feedController.feeds[index],
                              );
                            }
                          },
                        ),
                ),

                SizedBox(
                  height: 15,
                ),
                // getRecommend(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBar() {
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
                  Obx(
                    () => Text(
                      "Hello, ${userController.user.value.name![0].toUpperCase()}${userController.user.value.name!.substring(1)}",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Good Morning!",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
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

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // getCategories(),
            SizedBox(
              height: 15,
            ),

            getFeature(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  buildPostField() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "What do you want to learn?",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildPostButton(
      {required IconData icon, required String label, required Color color}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  getFeature() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 290,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: List.generate(
        features.length,
        (index) => FeatureItem(
          onTap: () {},
          feeds: features[index],
        ),
      ),
    );
  }
}
