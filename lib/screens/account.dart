import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:online_course/controller/authentication.dart';
import 'package:online_course/controller/user.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/custom_image.dart';
import 'package:online_course/widgets/account_item_icon_holder.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: appBgColor,
            pinned: true,
            snap: true,
            floating: true,
            title: getHeader(),
          ),
          SliverToBoxAdapter(child: getBody())
        ],
      ),
    );
  }

  getHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Account",
            style: TextStyle(
                color: textColor, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      "assets/icons/profile.svg",
                      color: Colors.grey,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${userController.user.value.name}".toUpperCase(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(children: [
              AccountItemHolder(
                title:
                    "${userController.user.value.name?[0].toUpperCase()}${userController.user.value.name?.substring(1)}",
                // leadingIcon: "assets/icons/heart.svg",
                bgIconColor: purple,
                onTap: () {}, iconData: Icons.person,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Divider(
                  height: 0,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
              AccountItemHolder(
                title: "${userController.user.value.email}",
                // leadingIcon: "assets/icons/shield.svg",
                bgIconColor: orange,
                onTap: () {}, iconData: Icons.email,
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                AccountItemHolder(
                  title: "Log Out",
                  // leadingIcon: "assets/icons/logout.svg",
                  bgIconColor: darker,
                  onTap: () {
                    _authenticationController.logoutUser();
                  },
                  iconData: Icons.logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
