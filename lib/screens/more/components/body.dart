import 'package:diabetesapp/screens/more/components/daily_steps_page.dart';
import 'package:diabetesapp/screens/more/components/update_infor_screen.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'infor.dart';
import 'menu_item.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Info(
            image: "assets/images/s1.png",
            name: "Jhon Doe",
            email: "Jhondoe01@gmail.com",
          ),
          SizedBox(height: SizeConfig.defaultSize * 2), //20
          MenuItem(
            iconSrc: "assets/icons/user.svg",
            title: "Thông tin tài khoản",
            press: () {
              Navigator.pushNamed(context, EditProfilePage.routeName);
            },
          ),
          MenuItem(
            iconSrc: "assets/icons/runner.svg",
            title: "Hoạt động hằng ngày",
            press: () {
              Navigator.pushNamed(context, DailyStepsPage.routeName);
            },
          ),
          MenuItem(
            iconSrc: "assets/icons/info.svg",
            title: "Trợ giúp",
            press: () {},
          ),
          MenuItem(
            iconSrc: "assets/icons/exit.svg",
            title: "Đăng xuất",
            press: () {},
          ),
        ],
      ),
    );
  }
}
