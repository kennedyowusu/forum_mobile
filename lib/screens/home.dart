import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_course/controller/post.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/category_box.dart';
import 'package:online_course/widgets/feature_item.dart';
import 'package:online_course/widgets/notification_box.dart';
import 'package:online_course/widgets/recommend_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final localStorage = GetStorage();
final fetchUser = localStorage.read('token');

final PostController feedController = Get.put(PostController());

TextEditingController _postController = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
                // getCategories(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
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
                          onTap: () {},
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 15.0),
                //   child: Container(
                //     height: height * 0.1,
                //     padding: EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: TextFormField(
                //       decoration: InputDecoration(
                //         hintText: "What do you want to learn?",
                //         hintStyle: TextStyle(
                //           color: Colors.grey,
                //           fontSize: 16,
                //         ),
                //         border: InputBorder.none,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 15,
                ),
                // getFeature(),

                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: feedController.posts.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () {
                        return feedController.isLoading.value
                            ? CircularProgressIndicator(
                                color: primary,
                              )
                            : FeatureItem(
                                onTap: () {
                                  print("hello ");
                                },
                                post: feedController.posts[index],
                              );
                      },
                    );
                  },
                ),

                SizedBox(
                  height: 15,
                ),
                // getRecommend(),
              ],
            ),
          ),
        ),

        // body: CustomScrollView(
        //   slivers: [
        //     SliverAppBar(
        //       backgroundColor: appBarColor,
        //       pinned: true,
        //       snap: true,
        //       floating: true,
        //       title: getAppBar(),
        //     ),
        //     SliverList(
        //       delegate: SliverChildBuilderDelegate(
        //         (context, index) => buildBody(),
        //         childCount: 1,
        //       ),
        //     )
        //   ],
        // ),
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
                  Text(
                    profile["name"]!,
                    style: TextStyle(
                      color: labelColor,
                      fontSize: 14,
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
            NotificationBox(
              notifiedNumber: 1,
              onTap: () {},
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

            // Padding(
            //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            //   child: Text("Featured",
            //       style: TextStyle(
            //         color: textColor,
            //         fontWeight: FontWeight.w600,
            //         fontSize: 24,
            //       )),
            // ),
            getFeature(),
            SizedBox(
              height: 15,
            ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Recommended",
            //         style: TextStyle(
            //             fontSize: 22,
            //             fontWeight: FontWeight.w600,
            //             color: textColor),
            //       ),
            //       Text(
            //         "See all",
            //         style: TextStyle(fontSize: 14, color: darker),
            //       ),
            //     ],
            //   ),
            // ),
            // getRecommend(),
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
                  // image: DecorationImage(
                  //   image: AssetImage(profile["image"]!),
                  //   fit: BoxFit.cover,
                  // ),
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

  int selectedCollection = 0;
  getCategories() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CategoryBox(
              selectedColor: Colors.white,
              data: categories[index],
              onTap: () {
                setState(() {
                  selectedCollection = index;
                });
              },
            ),
          ),
        ),
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
          post: features[index],
        ),
      ),
    );
  }

  getRecommend() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          recommends.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RecommendItem(
              data: recommends[index],
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
