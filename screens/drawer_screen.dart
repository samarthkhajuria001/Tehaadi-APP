import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tehaadi/constants/colors.dart';
import 'package:tehaadi/main.dart';
import 'package:tehaadi/services/authServices/auth_serviced.dart';
import 'package:tehaadi/utils/utils.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondaryBackgroundColor,
      width: MediaQuery.of(context).size.width * .5,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 75),
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 26,
              color: primaryBackgroudColor,
            ),
            title: const Text(
              'Tasks',
              style: TextStyle(fontSize: 18, color: primaryBackgroudColor),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(homeScreen, (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 26,
              color: primaryBackgroudColor,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 18, color: primaryBackgroudColor),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 26,
              color: primaryBackgroudColor,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 18, color: primaryBackgroudColor),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(settingScreen, (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.feedback_outlined,
              size: 26,
              color: primaryBackgroudColor,
            ),
            title: const Text(
              'Feedback',
              style: TextStyle(fontSize: 18, color: primaryBackgroudColor),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(feedbackScreen, (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 26,
              color: primaryBackgroudColor,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18, color: primaryBackgroudColor),
            ),
            onTap: () async {
              String res = await AuthServices.firebase().logoutUser();
              showSnackBar(context, res);
            },
          )
        ],
      ),
    );
  }
}
